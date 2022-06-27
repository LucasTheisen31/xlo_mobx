import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';

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
    }  else {
      return 'Email invalido';
    }
  }

  @observable
  String? password;

  @action
  void setPass(String password){
    this.password = password;
  }

  @computed
  bool get passwordValid => password!.length >= 6;
  String? get passwordError{
    if (password == null || passwordValid) {
      return null;
    }  else {
      return 'Senha deve ter 6 digitos';
    }
  }

  @computed
  bool get isFormValid => emailValid && passwordValid;

  @computed
  dynamic get loginPressed => (isFormValid) ? (){} : null;

}
