import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/repositorios/user_repositorio.dart';

import '../models/user.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
*/

part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {

  //construtor
  _UserManagerStore(){
    getCurrentUser();
  }

  @observable
  User? user;

  @action
  void setUser(User? user){
    this.user = user;
  }

  @computed
  //retorna true se tiver um usuario logad, senao fasle
  bool get isLoggedIn => user != null;

  //funcao para peagar o usuario ja logado no app()
  Future<void> getCurrentUser() async {
    User? user = await UserRepositorio().currentUser();
    //se nao tiver um usuario atual logado retona null e seta o user como null (atualizando a tela)
    setUser(user);
  }


}