import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/user.dart';
import 'category.dart';

enum AnuncioStatus { PENNDING, ACTIVE, SOLD, DELETE }

class Anuncio {
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
}
