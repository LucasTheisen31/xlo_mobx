import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/repositorios/cep_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'cep_store.g.dart';

class CepStore = _CepStore with _$CepStore;

abstract class _CepStore with Store {
  _CepStore() {
    autorun((_) => {
          if (clearCep.length != 8) {_reset()} else {_searchCep()}
        });
  }

  @observable
  String? cep = '';

  @action
  void setCep(String cep) => this.cep = cep;

  @computed
  String get clearCep => cep!.replaceAll(RegExp('^[0-9]'), '');

  @observable
  Address? address;

  @observable
  String? error;

  @observable
  bool loading = false;

  //metodo para buscar o cep no repositorio
  @action
  Future<void> _searchCep() async {
    loading = true;

    try {
      address = await CepRepository().getAddressFromApi(clearCep);
      error = null;
    } catch (e) {
      error = e.toString();
      address = null;
    }

    loading = false;
  }

  //metodo para resetar
  @action
  void _reset() {
    address = null;
    error = null;
  }
}
