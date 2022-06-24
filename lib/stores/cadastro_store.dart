import 'package:mobx/mobx.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
*/

part 'cadastro_store.g.dart';

class CadastroStore = _CadastroStore with _$CadastroStore;

abstract class _CadastroStore with Store {
  @observable
  String? name;

  @action
  void setName(String name) {
    this.name = name;
  }

  @computed
  String? get nameError {
    if (name != null && name!.length >= 6) {
      return null;
    } else if (name == null || name!.isEmpty) {
      return 'Nome não pode sr vazio';
    } else {
      return 'Nome muito curto';
    }
  }
}
