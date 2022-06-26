import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositorios/parse_errors.dart';
import 'package:xlo_mobx/repositorios/table_keys.dart';

class UserRepositorio {
  //metodo para cadastrar um usuario no banco (se cadastrado com sucesso ja retorna um User com os dados do usuario cadastrado no banco)
  Future<User> cadastrar(User user) async {
    //cria o usuario com os dados
    final parseUser = ParseUser(user.email, user.passwrod, user.email);
    //compos adicionais da tabela do usuario
    parseUser.set<String>(keyUserName, user.name);
    /*parseUser.set<String>(keyUserEmail, user.email);*/
    parseUser.set<String>(keyUserPhone, user.phone);
    /*type.index (0 = PARTICULAR, 1 = PROFESSIONAL)*/
    parseUser.set(keyUserType, user.type.index);

    final response = await parseUser
        .signUp(); //espera registra o usuario no banco e quando registrar retorna (se salvou ou nao)
    if (response.success) {
      //chama a função abaixo que instancia um User com os dados retornados do ParseSerer (response.result tem os dados do usuario criado no Banco)
      return mapParseToUser(response.result);
    } else {
      //chama a funcao ParseErrors.getDescription(response.error!.code) passando o codigo do erro(a classe ira retornar a string relacionada ao erro)
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  //funcao para converter um ParseUser (retornado do ParseServer) em um objeto da classe User
  User mapParseToUser(ParseUser parseUser) {
    return User(
      id: parseUser.objectId,
      name: parseUser.get(keyUserName),
      email: parseUser.get(keyUserEmail),
      phone: parseUser.get(keyUserPhone),
      //UserType é o ENUMERADOR do tipo do usuario (0 = PARTICULAR, 1 = PROFESSIONAL)
      type: UserType.values[parseUser.get(keyUserType)],
      createdAt: parseUser.get(keyUserCreatedAt),
    );
  }
}
