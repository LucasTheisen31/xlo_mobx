import 'package:mobx/mobx.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
*/

part 'cadastro_store.g.dart';

class CadastroStore = _CadastroStore with _$CadastroStore;

abstract class _CadastroStore with Store {
  @observable//variaveis observaveis
  String? name;
  String? email;
  String? celular;
  String? password;

  @action //equivalente aos setters
  void setName(String name) {
    this.name = name;
  }

  void setEmail(String email){
    this.email = email;
  }

  void setCelular(String celular){
    this.celular = celular;
  }

  void setPassword(String password){
    this.password = password;
  }

  @computed //equivalente aos getters
  bool get nameValid => name!.length >= 6;
  String? get nameError {
    if (name == null ||  nameValid) {
      return null;
    } else if (name!.isEmpty) {
      return 'Compo obrigatorio';
    } else {
      return 'Nome muito curto';
    }
  }


}
