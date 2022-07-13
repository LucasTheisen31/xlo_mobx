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
  //atributos
  String? id;
  late List? images;
  String? title;
  String? description;
  Category? category;
  Address? address;
  num? price;
  bool? hidePhone;
  AnuncioStatus? status = AnuncioStatus.PENNDING;
  DateTime? createDate;
  User? user;
  int? views;

  //metodos
  //construtor vazio
  Anuncio();
  //transforma um ParseObject retornado do Parse em um objeto Anuncio
  Anuncio.fromParse(ParseObject object) {
    id = object.objectId;
    title = object.get<String>(keyAnuncioTitle);
    description = object.get<String>(keyAnuncioDescription);
    images = object.get<List>(keyAnuncioImages)!.map((e) => e.url).toList();
    hidePhone = object.get<bool>(keyAnuncioHidePhone);
    price = object.get<num>(keyAnuncioPrice);
    createDate = object.createdAt;
    //instancia um Address
    address = Address(
      district: object.get<String>(keyAnuncioDistrict),
      //instancia uma cidade
      city: City(
        nome: object.get<String>(keyAnuncioCity),
      ),
      cep: object.get<String>(keyAnuncioPostalCode),
      uf: UF(
        sigla: object.get<String>(keyAnuncioFederativeUnit),
      ),
    );
    views = object.get<int>(keyAnuncioViews, defaultValue: 0);
    //instancia uma Categoria
    category = Category.fromParse(
      object.get<ParseObject>(keyAnuncioCategory)!,
    );
    status = AnuncioStatus.values[object.get<int>(keyAnuncioStatus)!];
    //instancia um Usuario
    user = UserRepositorio().mapParseToUser(
      object.get<ParseUser>(keyAnuncioOwner)!,
    );
  }
}