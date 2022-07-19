import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositorios/user_repositorio.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStore with _$EditAccountStore;

abstract class _EditAccountStore with Store {
  //construtor
  _EditAccountStore() {
    //pega o usuario atual
    user = userManagerStore.user!;

    //inicia os campos do formulario com as dados do usuario para depois editar se quiser
    userType = user.type;
    name = user.name;
    phone = user.phone;
  }

  late User user;

  //para dar acesso ao UserManagerSotre atravez do GetIt
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @observable
  UserType? userType;

  @action
  void setUserType(int? value) => userType = UserType.values[value!];

  @observable
  String? name;

  @action
  void setName(String? value) => name = value;

  @computed
  bool get nameValid => name != null && name!.length >= 6;
  String? get nameError =>
      (nameValid || name == null) ? null : 'Campo obrigatorio';

  @observable
  String? phone;

  @action
  void setPhone(String? value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone!.length >= 14;
  String? get phoneError =>
      (phoneValid || phone == null) ? null : 'Campo obrigatorio';

  @observable
  String? pass1 = '';

  @action
  void setPass1(String? value) => pass1 = value!;

  @observable
  String? pass2 = '';

  @action
  void setPass2(String? value) => pass2 = value;

  @computed
  bool get passValid =>
      pass2 == pass1 && (pass1!.length >= 6 || pass1!.isEmpty);

  @computed
  bool get isFormValid => nameValid && phoneValid && passValid;
  String? get passError {
    if (pass1!.isNotEmpty && pass1!.length < 6) {
      return 'Senha muito curta';
    } else if (pass1 != pass2) {
      return 'Senhas não coincidem';
    } else {
      return null;
    }
  }

  @observable
  bool loading = false;

  @computed
  //se o formulario for valido (todos os campos validos e nao estiver carregando, retorna a funcao save)
  dynamic get savePressed => (isFormValid && !loading) ? _save : null;

  @action
  Future<void> _save() async {
    loading = true;
    //salva os dados atualizados dos campos no usuario para depois salvalo no ParseServer
    user.name = name!;
    user.phone = phone!;
    user.type = userType!;
    //verifica se a senha foi alterada
    if (pass1!.isNotEmpty) {
      user.password = pass1;
    } else {
      user.password = null;
    }

    try {
      await UserRepositorio().save(user);
      //atualiza o usuario localmente(todos os locais que tiverem objervando o usuario vai atualizar)
      userManagerStore.setUser(user);
    } catch (e) {
      print(e.toString());
    }

    loading = false;
  }

  void logout() {
    userManagerStore.logout();
  }
}
