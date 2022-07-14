import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/stores/home_store.dart';

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
  _FilterStore(
      {this.orderBy = OrderBy.DATE,
      this.minPrice,
      this.maxPrice,
      this.vendorType = VENDOR_TYPE_PARTICULAR});

  @observable
  OrderBy orderBy;

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
  int vendorType;

  @action
  void selectVendorType(int value) => vendorType = value;
  void setVendorType(int type) => vendorType = (vendorType | type);
  void resetVendorType(int type) => vendorType = (vendorType & ~type);

  @computed
  bool get isTypeParticular => vendorType & VENDOR_TYPE_PARTICULAR != 0;
  bool get isTypeProfessional => vendorType & VENDOR_TYPE_PROFESSIONAL != 0;

  @computed
  bool get isFormValid => priceError == null;

  //metodo save pasando para o HomeStore o FilterStore atual
  void save() {
    GetIt.I<HomeStore>().setFilter(this as FilterStore);
  }

  //retorna uma nova instancia de FilterStore com os mesmos dados da anterior
  FilterStore clone() {
    return FilterStore(
      orderBy: orderBy,
      maxPrice: maxPrice,
      minPrice: minPrice,
      vendorType: vendorType,
    );
  }
}
