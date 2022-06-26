import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositorios/table_keys.dart';

class UserRepositorio{

  cadastrar(User user){
    final parseUser = ParseUser(user.email, user.passwrod, user.email);

    parseUser.set<String>(keyUserName, user.name);
    /*parseUser.set<String>(keyUserEmail, user.email);*/
    parseUser.set<String>(keyUserPhone, user.phone);
    /*userType.index (0 = PARTICULAR, 1 = PROFESSIONAL)*/
    parseUser.set(keyUserType, user.userType.index);
  }
}