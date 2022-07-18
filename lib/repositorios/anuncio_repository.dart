import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/anuncio.dart';
import 'package:path/path.dart' as path;
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositorios/parse_errors.dart';
import 'package:xlo_mobx/repositorios/table_keys.dart';
import 'package:xlo_mobx/stores/filter_store.dart';
import '../stores/user_manager_store.dart';

final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

class AnuncioRepository {
  //metodo para buscar os anuncios de acordo com os dados passados
  Future<List<Anuncio>> getHomeAnuncioList({
    String? search,
    Category? category,
    FilterStore? filterStore,
    required int page,
  }) async {
    try {
      //busca, informar em qual tabela vai buscar, QueryBuilder é onde vamos configurar todos os parametros da busca qe o ParseServer vai realizar
      final queryBuilder =
          QueryBuilder<ParseObject>(ParseObject(keyAnuncioTable));

      //informamos que alem do objeto Anuncio queremos o Objeto Usuario e o Objeto categoria que estao vinculados ao Anuncio
      queryBuilder.includeObject([keyAnuncioOwner, keyAnuncioCategory]);

      //diz pára pular (o numero da pagina * 20) itens na consulta, isso para fazer o efeito de paginacao
      queryBuilder.setAmountToSkip(page * 10);

      //seta o limite de 20 anuncios por consulta
      queryBuilder.setLimit(10);

      //filtra a busca somente pelos anuncios que estao com o status ativo (passa por todos os anuncios mas so pega os que tiver a coluna status como ativo (index pois é o indice do ENUMERADOR))
      queryBuilder.whereEqualTo(keyAnuncioStatus, AnuncioStatus.ACTIVE.index);

      if (search != null && search.trim().isNotEmpty) {
        //se search nao for null vai filtrar pelo titulo dos anuncios que forem iguais a search e desconsiderando o caseSensitive
        queryBuilder.whereContains(keyAnuncioTitle, search,
            caseSensitive: false);
      }

      if (category != null && category.id != '*') {
        /*se categoria for != null vai filtar pelos anuncios que tiverem a coluna category(que contem o id da categoria) igual ao id da categoria passada,
       apontamos para a tebela categoria que tiver o id igual ao da categoria passada
       */
        queryBuilder.whereEqualTo(
          keyAnuncioCategory,
          (ParseObject(keyCategoryTable)..set(keyCategoryId, category.id))
              .toPointer(),
        );
      }

      //ordenar pela data ou pelo preco
      switch (filterStore!.orderBy) {
        case OrderBy.PRICE:
          //ordenando de forma acendente pela coluna de preço
          queryBuilder.orderByAscending(keyAnuncioPrice);
          break;
        case OrderBy.DATE:
          //ordenar de forma descendende pela coluna de data criada
          queryBuilder.orderByDescending(keyAnuncioCreatedAt);
          break;
        default:
          //caso de algum problema ordenar de forma descendende pela coluna de data criada
          queryBuilder.orderByDescending(keyAnuncioCreatedAt);
          break;
      }

      //agora filtros de preço
      if (filterStore.minPrice != null && filterStore.minPrice! > 0) {
        //aonde for maior ou igual ao preço minimo
        queryBuilder.whereGreaterThanOrEqualsTo(
            keyAnuncioPrice, filterStore.minPrice);
      }

      if (filterStore.maxPrice != null && filterStore.maxPrice! > 0) {
        //aonde for menor ou igual ao preço maximo
        queryBuilder.whereLessThanOrEqualTo(
            keyAnuncioPrice, filterStore.maxPrice);
      }

      //agora filtro pelo tipo de vendedor
      if (filterStore.vendorType != null &&
          filterStore.vendorType > 0 &&
          filterStore.vendorType <
              (VENDOR_TYPE_PROFESSIONAL | VENDOR_TYPE_PARTICULAR)) {
        final userQuery = QueryBuilder<ParseUser>(ParseUser.forQuery());

        //Se o tipo de usuario selecionado for Particular
        if (filterStore.vendorType == VENDOR_TYPE_PARTICULAR) {
          userQuery.whereEqualTo(keyUserType, UserType.PARTICULAR.index);
        }

        //Se o tipo de usuario selecionado for Professional
        if (filterStore.vendorType == VENDOR_TYPE_PROFESSIONAL) {
          userQuery.whereEqualTo(keyUserType, UserType.PROFESSIONAL.index);
        }
        //Se os dois tipos de usuarios forem selecionados nao precisa filtrar por tipo de usuario pois ja mostra os 2 tipos
        //agora precisamos juntar a QueryBuiler com a UserQuery(vai juntar um anuncio e seu criador)
        queryBuilder.whereMatchesQuery(keyAnuncioOwner, userQuery);
      }
      //executa a busca e armazena seu resultado
      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        //response contem uma lista de ParseObject entao precisamos converter essa lista de parse Object em uma lista de Anuncions
        return response.results!.map((e) => Anuncio.fromParse(e)).toList();
      } else if (response.success && response.results == null) {
        //se nao encontrar nenum resultado na busca retorna uma lista vazia
        return [];
      } else {
        //chama a funcao ParseErrors.getDescription(response.error!.code) passando o codigo do erro(a classe ira retornar a string relacionada ao erro)
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  //metodo para salvar um anuncio
  Future<void> saveAnuncio(Anuncio anuncio) async {
    try {
      //chama o metodo para salvar as imagens no parse server e o parse retorna uma lista das imagens no formato ParseFile
      final parseImages = await saveImages(anuncio.images!);
      //cria um parse user e dizemos que o id dele é o id do usuario que esta no anuncio (Estamos criando relacionamento criando um anuncio e colocando um id de usuario nele)
      final parseUser = await ParseUser.currentUser() as ParseUser;
      //cria um objeto (registro da tabela de anuncio)
      final anuncioObject = ParseObject(keyAnuncioTable);

      if (anuncio.id != null) {
        //se o anuncio passado ja tem um id (ou seja se é um anuncio que esta sendo editado precisa usar o mesmo id do anuncio passado para nao criar um novo)
        anuncioObject.objectId = anuncio.id;
      }

      //definir as permissões deste objeto(tabela)
      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);
      anuncioObject.setACL(parseAcl);
      //setar os dados do anuncio (demais campos)
      anuncioObject.set<String>(keyAnuncioTitle, anuncio.title!);
      anuncioObject.set<String>(keyAnuncioDescription, anuncio.description!);
      anuncioObject.set<bool>(keyAnuncioHidePhone, anuncio.hidePhone!);
      anuncioObject.set<num>(keyAnuncioPrice, anuncio.price!);
      anuncioObject.set<int>(keyAnuncioStatus, anuncio.status!.index);

      anuncioObject.set<String>(keyAnuncioDistrict, anuncio.address!.district!);
      anuncioObject.set<String>(keyAnuncioCity, anuncio.address!.city!.nome!);
      anuncioObject.set<String>(
          keyAnuncioFederativeUnit, anuncio.address!.uf!.sigla!);
      anuncioObject.set<String>(keyAnuncioPostalCode, anuncio.address!.cep!);

      anuncioObject.set<List<ParseFile>>(keyAnuncioImages, parseImages);

      anuncioObject.set<ParseUser>(keyAnuncioOwner, parseUser);
      //criando relacao entre objeto do anuncio(tabela do anuncio) e objeto categoria (tabela da categoria)
      anuncioObject.set<ParseObject>(
          keyAnuncioCategory,
          ParseObject(keyCategoryTable)
            ..set(keyCategoryId, anuncio.category!.id));
      //salva o anuncio no ParseServer
      final response = await anuncioObject.save();

      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      return Future.error('Falha ao salvar anuncio');
    }
  }

  /* metodo para salvar as imagens no parse server e o parse retorna uma lista das imagens no formato ParseFile.
  Lembrando que este metodo pode receber imagens que ja esta no ParseServer (formato ParseFile) e imagens q ainda nao estão */
  Future<List<ParseFile>> saveImages(List images) async {
    //lista do tipo ParseFile
    final parseImages = <ParseFile>[];

    try {
      //for para percorrer a lista de imagens veriricando cada uma delas
      for (final image in images) {
        if (image is String) {
          final parseFile = ParseFile(File(path.basename(image)));
          parseFile.name = path.basename(image);
          parseFile.url = image;
          parseImages.add(parseFile);
        } else {
          final parseFile = ParseFile(image, name: path.basename(image.path));
          final response = await parseFile.save();
          if (!response.success) {
            return Future.error(
                ParseErrors.getDescription(response.error!.code));
          }
          parseImages.add(parseFile);
        }
      }
      return parseImages; //retorna a lista de img

    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //meodo para buscar os anuncios do usuario passado
  Future<List<Anuncio>> getMeusAnuncios(User user) async {
    //cria um parse user
    //cria um parse user e dizemos que o id dele é o id do usuario que esta no anuncio (Estamos criando relacionamento criando um anuncio e colocando um id de usuario nele)
    final currentUser = await ParseUser.currentUser() as ParseUser;
    //Montando a consulta (Query), informamos que a busca vais ser na tabela(Objeto) de Anuncios
    final queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(keyAnuncioTable));
    //limite de 100 anuncios por consulta
    queryBuilder.setLimit(100);
    //ordenando pela coluna data de criação
    queryBuilder.orderByDescending(keyAnuncioCreatedAt);
    //aonde a coluna AnuncioOwner for igual ao parseUser passado (a coluna AnuncioOwner é um ponteiro para o usuario que criou o anuncio )
    queryBuilder.whereEqualTo(keyAnuncioOwner, currentUser.toPointer());
    //dizemos para trazer na busca todos os dados da categoria e do usuario Owner que criou o anuncio
    queryBuilder.includeObject([keyAnuncioCategory, keyAnuncioOwner]);

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      //response contem uma lista de ParseObject entao precisamos converter essa lista de parse Object em uma lista de Anuncions
      return response.results!.map((e) => Anuncio.fromParse(e)).toList();
    } else if (response.success && response.results == null) {
      //se nao encontrar nenum resultado na busca retorna uma lista vazia
      return [];
    } else {
      //chama a funcao ParseErrors.getDescription(response.error!.code) passando o codigo do erro(a classe ira retornar a string relacionada ao erro)
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  Future<void> sold(Anuncio anuncio) async {
    //pegamos a referencia do objeto que esta no banco
    final parseObject = ParseObject(keyAnuncioTable)
      ..set(keyAnuncioId, anuncio.id);
    //setamos o status como vendido
    parseObject.set(keyAnuncioStatus, AnuncioStatus.SOLD.index);

    //mandamos salvar e aguardamos a resposta
    final response = await parseObject.save();
    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  Future<void> delete(Anuncio anuncio) async {
    //pegamos a referencia do objeto que esta no banco
    final parseObject = ParseObject(keyAnuncioTable)
      ..set(keyAnuncioId, anuncio.id);
    //setamos o status como deletado
    parseObject.set(keyAnuncioStatus, AnuncioStatus.DELETE.index);

    //mandamos salvar e aguardamos a resposta
    final response = await parseObject.save();
    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }
}
