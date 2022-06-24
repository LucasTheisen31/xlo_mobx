import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
*/

part 'cadastro_store.g.dart';

class CadastroStore = _CadastroStore with _$CadastroStore;

abstract class _CadastroStore with Store {
  //NOME
  @observable /*variavel observavel*/
  String? name;

  @action /*equivalente ao setter*/
  void setName(String name) {
    this.name = name;
  }

  @computed /*equivalente ao getter*/
  bool get nameValid => name!.length >= 6;

  String? get nameError {
    if (name == null || nameValid) {
      return null;
    } else if (name!.isEmpty) {
      return 'Compo obrigatorio';
    } else {
      return 'Nome muito curto';
    }
  }

  //EMAIL
  @observable
  String? email;

  @action
  void setEmail(String email) {
    this.email = email;
  }

  @computed
  bool get isEmailValid => email != null && email!.isEmailValid();

  String? get emailError {
    if (email == null || isEmailValid) {
      return null;
    } else if (email!.isEmpty) {
      return 'Compo obrigatorio';
    } else {
      return 'E-mail invalido';
    }
  }

  //TELEFONE
  @observable
  String? celular;

  void setCelular(String celular) {
    this.celular = celular;
  }

  @computed
  bool get phoneValid => celular!.length >= 14;

  String? get phoneError {
    if (celular == null || phoneValid) {
      return null;
    } else if (celular!.isEmpty) {
      return 'Campo obrigatorio';
    } else {
      return 'Celular invalido';
    }
  }

  //PASSWORD 1
  @observable
  String? password1;

  @action
  void setPassword1(String password1) {
    this.password1 = password1;
  }

  @computed
  bool get password1Valid => password1!.length >= 6;
  String? get password1Error {
    if (password1 == null || password1Valid) {
      return null;
    } else if (password1!.isEmpty) {
      return 'Campo obrigatorio';
    } else {
      return 'Senha muito curta';
    }
  }

  //PASSWORD 2
  @observable
  String? password2;

  @action
  void setPassword2(String password2) {
    this.password2 = password2;
  }

  @computed
  bool get password2Valid => password2 == password1;
  String? get password2Error{
    if (password2 == null || password2Valid) {
      return null;
    }  else{
      return 'Senhas não coincidem';
    }
  }
}
