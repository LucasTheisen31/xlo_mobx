import 'package:mobx/mobx.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'filter_store.g.dart';

//ENUMERADOR PARA INDICAR SE O FILTRO É POR DATA OU POR preço
enum OrderBy { DATE, PRICE }

const VENDOR_TYPE_PARTICULAR = 1 << 0; // 0001
const VENDOR_TYPE_PROFESSIONAL = 1 << 1; // 0010

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  @observable
  OrderBy orderBy = OrderBy.DATE;

  @action
  void setOrderBy(OrderBy value) => orderBy = value;

  @observable
  int? minPrice;

  @action
  void setMinPrice(int? value) => minPrice = value;

  @observable
  int? maxPrice;

  @action
  void setMaxPrice(int? value) => maxPrice = value;

  @computed
  String? get priceError =>
      maxPrice != null && minPrice != null && maxPrice! < minPrice!
          ? 'Faixa de preço invalida'
          : null;

  @observable
  int vendorType = 0;

  @action
  void selectVendorType(int value) => vendorType = value;
  void setVendorType(int type) => vendorType = vendorType | type;
  void resetVendorType(int type) => vendorType = vendorType & ~type;

  @computed
  bool get isTypeParticular => vendorType & VENDOR_TYPE_PARTICULAR != 0;
  bool get isTypeProfessional => vendorType & VENDOR_TYPE_PROFESSIONAL != 0;
}
