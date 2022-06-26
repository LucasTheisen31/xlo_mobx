import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositorios/table_keys.dart';

class UserRepositorio {
  //metodo para cadastrar um usuario no banco
  Future<void> cadastrar(User user) async {
    //cria o usuario com os dados
    final parseUser = ParseUser(user.email, user.passwrod, user.email);
    //compos adicionais da tabela do usuario
    parseUser.set<String>(keyUserName, user.name);
    /*parseUser.set<String>(keyUserEmail, user.email);*/
    parseUser.set<String>(keyUserPhone, user.phone);
    /*type.index (0 = PARTICULAR, 1 = PROFESSIONAL)*/
    parseUser.set(keyUserType, user.type.index);

    final response = await parseUser.signUp(); //espera registra o usuario no banco e quando registrar retorna (se salvou ou nao)
    if (response.success) {

    }  else{
      return Future.error(response.error!.code);
    }
  }
}
