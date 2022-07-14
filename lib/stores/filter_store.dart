import 'package:mobx/mobx.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'filter_store.g.dart';

//ENUMeRADOR PARA INDICAR SE O FILTRO É POR DATA OU POR preço

enum OrderBy { DATE, PRICE }

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  @observable
  OrderBy orderBy = OrderBy.DATE;

  @action
  void setOrderBy(OrderBy value) => orderBy = value;
}
