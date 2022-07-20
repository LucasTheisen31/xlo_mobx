import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/uf.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositorios/table_keys.dart';
import 'package:xlo_mobx/repositorios/user_repositorio.dart';
import 'category.dart';
import 'city.dart';

enum AnuncioStatus { PENNDING, ACTIVE, SOLD, DELETE }

class Anuncio {
  //transforma um ParseObject retornado do Parse em um objeto Anuncio
  Anuncio.fromParse(ParseObject object) {
    id = object.objectId;
    title = object.get<String>(keyAnuncioTitle);
    description = object.get<String>(keyAnuncioDescription);
    images = object.get<List>(keyAnuncioImages)!.map((e) => e.url).toList();
    hidePhone = object.get<bool>(keyAnuncioHidePhone);
    price = object.get<num>(keyAnuncioPrice);
    createDate = object.createdAt;
    address = Address(
      district: object.get<String?>(keyAnuncioDistrict),
      city: City(nome: object.get<String?>(keyAnuncioCity)),
      cep: object.get<String?>(keyAnuncioPostalCode),
      uf: UF(sigla: object.get<String?>(keyAnuncioFederativeUnit)),
    );
    views = object.get<int>(keyAnuncioViews, defaultValue: 0);
    category = Category.fromParse(object.get<ParseObject>(keyAnuncioCategory)!);
    status = AnuncioStatus.values[object.get<int>(keyAnuncioStatus)!];
    user = UserRepositorio()
        .mapParseToUser(object.get<ParseUser>(keyAnuncioOwner)!);
    print(user);
  }
  //construtor vazio
  Anuncio();

  //atributos
  String? id;
  List? images = [];
  String? title;
  String? description;
  Category? category;
  Address? address;
  num? price;
  bool? hidePhone = false;
  AnuncioStatus? status = AnuncioStatus.PENNDING;
  DateTime? createDate;
  User? user;
  int? views;

  @override
  String toString() {
    return '***Anuncio{id: $id, images: $images, title: $title, description: $description, category: $category, address: $address, price: $price, hidePhone: $hidePhone, status: $status, createDate: $createDate, user: $user, views: $views}';
  }
}
