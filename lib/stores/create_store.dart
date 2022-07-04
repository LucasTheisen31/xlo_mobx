import 'package:mobx/mobx.dart';
import '../models/category.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
*/

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  //lista observavel para armazenar as imagens do novo anuncio, ObservableList nao precisa criar as actions para modificala pois ela ja possui suas actions internas para add e romover etc
  ObservableList? images = ObservableList();

  @observable
  Category? category;

  @action
  void setCategory(Category category) {
    this.category = category;
  }

  @observable
  bool hidePhone = false;

  @action
  void setHidePhone(bool? value) => hidePhone = value!;
}
