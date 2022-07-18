import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/anuncio.dart';
import 'package:xlo_mobx/repositorios/anuncio_repository.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import '../models/category.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
*/

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  //construtor
  _CreateStore(Anuncio anuncio) {
    //se for passado um anuncio(ou seja esta editando um anuncio entao preenche os campos com os dados do anuncio passado)
    title = anuncio.title ?? '';
    description = anuncio.description ?? '';
    images = anuncio.images?.asObservable();
    category = anuncio.category;
    priceText = anuncio.price?.toStringAsFixed(2) ?? '';
    hidePhone = anuncio.hidePhone ?? false;

    if (anuncio.address != null) {
      cepStore = CepStore(anuncio.address!.cep);
    } else {
      cepStore = CepStore(null);
    }
  }

  //lista observavel para armazenar as imagens do novo anuncio, ObservableList nao precisa criar as actions para modificala pois ela ja possui suas actions internas para add e romover etc
  ObservableList? images = ObservableList();

  @computed
  bool get imagesValid => images!.isNotEmpty;
  String? get imagesError {
    if (!showErrors || imagesValid) {
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
    if (!showErrors || titleValid) {
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
    if (!showErrors || descriptionValid) {
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
    if (!showErrors || categoryValid) {
      return null;
    } else {
      return 'Campo obrigatório';
    }
  }

  late CepStore cepStore;

  @computed
  Address? get address => cepStore.address;
  bool get addressValid => address != null;
  String? get addressError {
    if (!showErrors || addressValid) {
      return null;
    } else {
      return 'Campo obrigatório';
    }
  }

  @observable
  String priceText = '';

  @action
  void setPrice(String value) => priceText = value;

  @computed
  num? get price {
    if (priceText.contains(',') || priceText.contains('R')) {
      return num.tryParse(priceText.replaceAll(RegExp('[^0-9]'), ''))! / 100;
    } else {
      return num.tryParse(priceText);
    }
  }

  bool get priceValid => price != null && price! <= 9999999;
  String? get priceError {
    if (!showErrors || priceValid) {
      return null;
    } else if (priceText.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Preço inválido';
    }
  }

  @observable
  bool hidePhone = false;

  @action
  void setHidePhone(bool? value) => hidePhone = value!;

  //retorna se todos as campos do formulario sao validos
  @computed
  bool get formValid =>
      imagesValid &&
      titleValid &&
      descriptionValid &&
      categoryValid &&
      addressValid &&
      priceValid;

  //ativa ou desativa o botao de enviar(ativa se todos os campos forem validos)
  @computed
  dynamic get sendPressed => formValid ? _send : null;

  //para exibir os erros ou nao
  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  bool loading = false;

  @observable
  String? error;

  @observable
  bool anuncioSalvo = false;

  //funcao que vai instanciar um Objeto Anuncio
  @action
  Future<void> _send() async {
    Anuncio anuncio = Anuncio();
    anuncio.title = title;
    anuncio.description = description;
    anuncio.category = category;
    anuncio.price = price;
    anuncio.hidePhone = hidePhone;
    anuncio.images = images;
    anuncio.address = address;
    anuncio.user = GetIt.I<UserManagerStore>().user;

    loading = true;

    try {
      await AnuncioRepository().saveAnuncio(anuncio);
      anuncioSalvo = true;
    } catch (e) {
      error = e.toString();
    }

    loading = false;
  }
}
