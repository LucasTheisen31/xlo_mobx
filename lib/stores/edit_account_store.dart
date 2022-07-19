import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/user.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStore with _$EditAccountStore;

abstract class _EditAccountStore with Store {
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
}
