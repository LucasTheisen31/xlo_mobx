import 'package:mobx/mobx.dart';

import '../models/user.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
*/

part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {

  @observable
  User? user;

  @action
  void setUser(User user){
    this.user = user;
  }

  @computed
  //retorna true se tiver um usuario logad, senao fasle
  bool get isLoggedIn => user != null;

}