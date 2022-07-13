import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/anuncio.dart';
import 'package:path/path.dart' as path;
import 'package:xlo_mobx/repositorios/parse_errors.dart';
import 'package:xlo_mobx/repositorios/table_keys.dart';

import '../stores/user_manager_store.dart';

final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

class AnuncioRepository {
  Future<void> saveAnuncio(Anuncio anuncio) async {
    //chama o metodo para salvar as imagens no parse server e o parse retorna uma lista das imagens no formato ParseFile
    final parseImages = await saveImages(anuncio.images!);
    //cria um parse user e dizemos que o id dele é o id do usuario que esta no anuncio (Estamos criando relacionamento criando um anuncio e colocando um id de usuario nele)
    final parseUser = await ParseUser.currentUser() as ParseUser;
    //cria um objeto (registro da tabela de anuncio)
    final anuncioObject = ParseObject(keyAnuncioTable);
    //definir as permissões deste objeto(tabela)
    final parseAcl = ParseACL(owner: parseUser);
    parseAcl.setPublicWriteAccess(allowed: true);
    parseAcl.setPublicWriteAccess(allowed: true);
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
    print(response.success);
  }

  /* metodo para salvar as imagens no parse server e o parse retorna uma lista das imagens no formato ParseFile.
  Lembrando que este metodo pode receber imagens que ja esta no ParseServer (formato ParseFile) e imagens q ainda nao estão */
  Future<List<ParseFile>> saveImages(List images) async {
    //lista do tipo ParseFile
    final parseImages = <ParseFile>[];

    try {
      //for para percorrer a lista de imagens veriricando cada uma delas
      for (final image in images) {
        if (image is File) {
          //se a imagem for um File precisamos fazer upload desta imagen para o ParseServer (vamos usar o pacote path para pegar o nome do arquivo da imagem)
          final parseFile = ParseFile(image, name: path.basename(image.path));
          final response = await parseFile
              .save(); //salva no ParseServer e obtem a resposta do salvamento
          if (!response.success) {
            //se der errp converte o codigo do erro em uma descricao em portugues usando a classe ParseErrors metodo getDescription
            return Future.error(
                ParseErrors.getDescription(response.error!.code));
          }
          //add o parse file a lista
          parseImages.add(parseFile);
        } else {
          //caso a imagem seja apenas uma url que ja esta no ParseServer
          final parseFile = ParseFile(null); //cria um arquivo parseFile
          //define o nome como o da imagem que esta no ParseServer
          parseFile.name = path.basename(image);
          parseFile.url = image; //define a url da img
          parseImages.add(parseFile); //add o parseFile a lista de img
        }
      }

      return parseImages; //retorna a lista de img

    } catch (e) {
      return Future.error('Falha ao salvar imagens');
    }
  }
}
