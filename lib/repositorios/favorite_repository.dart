import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/anuncio.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositorios/parse_errors.dart';
import 'package:xlo_mobx/repositorios/table_keys.dart';

class FavoriteRepository {
  //metodo para carregar os favoritos quando abrir o aplicativo
  Future<List<Anuncio>> getFavorites(User user) async {
    //1º fazer uma query para buscar todos os favoritos, indicar em qual tabela fazer a busca = ParseObject(keyAnuncioTable)
    QueryBuilder<ParseObject> queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(keyFavoritoTable));

    //2º indicar a coluna que queremos (pela coluna Owner campos que forem iguais ao do Usuario passado, ou seja estamos pegando os anuncios do usuario em questao)
    queryBuilder.whereEqualTo(keyFavoritoOwner, user.id);

    /*3ºprecisamos incluir o objeto Anuncio na consulta pois a coluna anuncio é
    * um ponteiro para o objeto Anuncio que esta vinculado ao favorito, assim conseguimos trazer todos os dados do anuncio na consulta, para isso serve o ponteiro
    * mas tambem temos um usuario(ponteiro para um objeto User) vinculado a cada Anuncio e precisamos dos dados dele tambem entao usamos 'Anuncio.owner' para dizer que queremos
    * trazer junto na consulta os dados do User relacionado ao anuncio
    * resumindo esse comando abaixo diz para pegar todos os dados do Anuncio que esta vinculado ao Favorito e tambem diz para trazer os dados do User que esta vinculado ao anuncio*/
    queryBuilder.includeObject([keyFavoritoAnuncio, 'anuncio.owner']);

    //realizar a busca, response vai conter todos os dados correspondentes a esta busca (neste caso todos os anuncios relacionados com este usuario)
    final response = await queryBuilder.query();

    //se executou a busca com sucesso e trouse resultados
    if (response.success && response.results != null) {
      //pega a lista de resultados e pega o id do anuncio que esta relacionado em cada favorito e mapeia para um objeto Anuncio
      return response.results!
          .map((e) => Anuncio.fromParse(e.get(keyFavoritoAnuncio)))
          .toList();
    } else if (response.success && response.results == null) {
      // se nao encontrou favoritos
      return [];
    } else {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  //metodo que salva um anuncio nos favoritos
  Future<void> save({required Anuncio anuncio, required User user}) async {
    //1° criar um objeto(ParseObject) e especificar em qual tabela sera salvo
    final favoritoObject = ParseObject(keyFavoritoTable);
    //2°especificar quem sera o dono do anuncio, nao vamos usar ponteiro pois nao precisamos trazer os dados do usuario junto na coonsulta, entao so vamos armazenar o id do usuario
    favoritoObject.set<String>(keyFavoritoOwner, user.id!);
    //3°especificar qual o anuncio que esta sendo favoritado, agora vamos usar relacionamento, pois quando buscarmos o favorito tambem queremos as informaçoes do anuncio.
    favoritoObject.set<ParseObject>(keyFavoritoAnuncio,
        ParseObject(keyAnuncioTable)..set(keyAnuncioId, anuncio.id));
    //aguardamos salvar
    final response = await favoritoObject.save();
    if (!response.success) {
      //se nao salvar retorna o erro
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  //metodo que deletar um anuncio nos favoritos
  Future<void> delete({required Anuncio anuncio, required User user}) async {
    try {
      //1º fazer uma query para buscar todos os favoritos, indicar em qual tabela fazer a busca = ParseObject(keyAnuncioTable)
      QueryBuilder<ParseObject> queryBuilder =
          QueryBuilder<ParseObject>(ParseObject(keyFavoritoTable));
      //2º indicar a coluna que queremos (pela coluna Owner campos que forem iguais ao do Usuario passado, ou seja estamos pegando os anuncios do usuario em questao)
      queryBuilder.whereEqualTo(keyFavoritoOwner, user.id);
      //3ºindicar o anuncio que queremos
      queryBuilder.whereEqualTo(keyFavoritoAnuncio,
          ParseObject(keyAnuncioTable)..set(keyAnuncioId, anuncio.id));

      //realizar a busca, response vai conter todos os dados correspondentes a esta busca (neste cado é so 1 anuncio)
      final response = await queryBuilder.query();
      //se executou a busca com sucesso e trouse resultados
      if (response.success && response.result != null) {
        for (final f in response.results as List<ParseObject>) {
          //para cada resultado obtidos vamos apagalos
          await f.delete();
        }
      }
    } catch (e) {
      return Future.error(
          '************************ Falha ao deletar favorito *****************************');
    }
  }
}
