import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/user.dart';

class UserRepositorio{

  cadastrar(User user){
    final parseUser = ParseUser(user.email, user.passwrod, user.email);

  }
}