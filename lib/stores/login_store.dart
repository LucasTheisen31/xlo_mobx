import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/repositorios/user_repositorio.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import '../models/user.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
*/

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String? email;

  @action
  void setEmail(String email) {
    this.email = email;
  }

  @computed
  bool get emailValid => email != null && email!.isEmailValid();
  String? get emailError {
    if (email == null || emailValid) {
      return null;
    } else {
      return 'Email invalido';
    }
  }

  @observable
  String? password;

  @action
  void setPass(String password) {
    this.password = password;
  }

  @computed
  bool get passwordValid => password != null && password!.length >= 6;
  String? get passwordError {
    if (password == null || passwordValid) {
      return null;
    } else {
      return 'Senha deve ter 6 digitos';
    }
  }

  @computed
  bool get isFormValid => emailValid && passwordValid;

  @computed
  //se os dados de login e senha sao validos e nao esta carregando ativa o botao e quando clicado chama a funcao _login
  dynamic get loginPressed => (isFormValid && !loading) ? _login : null;

  @observable
  bool loading = false;

  //usado para recebe a mensagem do erro que ouve erro no login
  @observable
  String? error;

  @action
  Future<void> _login() async {
    loading = true;
    error = null;
    try {
      //tenta fazer o login se for sucesso o user vai contar todos os dados do usuario
      final User user =
          await UserRepositorio().loginWitchEmail(email!, password!);
      //faz o usuario ficar disponivel para ser acessado de qualquer local do app
      GetIt.I<UserManagerStore>().setUser(user);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
  }
}
