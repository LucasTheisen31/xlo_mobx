import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import '../models/category.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
*/

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  //lista observavel para armazenar as imagens do novo anuncio, ObservableList nao precisa criar as actions para modificala pois ela ja possui suas actions internas para add e romover etc
  ObservableList? images = ObservableList();

  @computed
  bool get imagesValid => images!.isNotEmpty;
  String? get imagesError {
    if (imagesValid) {
      return null;
    } else {
      return 'Insira imagens';
    }
  }

  @observable
  String? title = '';

  @action
  void setTitle(String? title) {
    this.title = title;
  }

  @computed
  bool get titleValid => title!.length >= 6;
  String? get titleError {
    if (titleValid) {
      return null;
    } else if (title!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return "Titulo muito curto";
    }
  }

  @observable
  String? description = '';

  @action
  void setDescription(String? description) {
    this.description = description;
  }

  @computed
  bool get descriptionValid => description!.length >= 10;
  String? get descriptionError {
    if (descriptionValid) {
      return null;
    } else if (description!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return "Descrição muito curta";
    }
  }

  @observable
  Category? category;

  @action
  void setCategory(Category category) {
    this.category = category;
  }

  @computed
  bool get categoryValid => category != null;
  String? get categoryError {
    if (categoryValid) {
      return null;
    } else {
      return 'Campo obrigatório';
    }
  }

  CepStore cepStore = CepStore();

  @computed
  Address? get address => cepStore.address;
  bool get addressValid => address != null;
  String? get addressError {
    if (addressValid) {
      return null;
    } else {
      return 'Campo obrigatório';
    }
  }

  @observable
  bool hidePhone = false;

  @action
  void setHidePhone(bool? value) => hidePhone = value!;
}
