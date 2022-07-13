import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositorios/parse_errors.dart';
import 'package:xlo_mobx/repositorios/table_keys.dart';

class UserRepositorio {
  //metodo para cadastrar um usuario no banco (se cadastrado com sucesso ja retorna um User com os dados do usuario cadastrado no banco)
  Future<User> cadastrar(User user) async {
    //cria o usuario com os dados
    final parseUser = ParseUser(user.email, user.password, user.email);
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

  //funcao para login com email
  Future<User> loginWitchEmail(String email, String password) async {
    final ParseUser parseUser = ParseUser(email, password, null);

    final response = await parseUser.login();

    //se o login for sucesso ele o parseUser.login() ja traz todas as informaçoes do usuario
    if (response.success) {
      //instancia um objeto User com os dados o usuario e retorna este usuario
      return mapParseToUser(response.result);
    } else {
      //retorna a mensagem de erro de acordo com o codigo do erro (response.error!.code)
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  //retorna o usuario que ja esta logado no aplicativo (Por exemplo quando inicia o app)
  Future<User?>? currentUser() async {
    //ParseUser.currentUser() Obtém o usuário atual logado no servidor
    final currentUser = await ParseUser.currentUser();
    if (currentUser != null) {
      //verifica se a sesao do usuario ja nao esta expirada (por exemplo se ja nao foi desconectado por que esta logado a muitos dias)
      final response =
          await ParseUser.getCurrentUserFromServer(currentUser.sessionToken);
      if (response!.success) {
        //se a sesao do usuario for valida ainda retorna instancia um objeto com os dados do usuario(que estao no servidor) e o retorna
        return mapParseToUser(currentUser);
      } else {
        //se a sesao do usuario nao for mais valida
        //fazemos o logout deste usuario removendo da memoria
        await currentUser.logout();
      }
    }
    return null;
  }
}
