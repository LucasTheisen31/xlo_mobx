import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/anuncio.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositorios/parse_errors.dart';
import 'package:xlo_mobx/repositorios/table_keys.dart';

class FavoriteRepository {
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
}
