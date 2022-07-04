import 'package:xlo_mobx/models/uf.dart';

import 'city.dart';

class Address {
  //construtor
  Address({this.uf, this.city, this.cep, this.district});

  //atributos
  UF? uf;
  City? city;

  String? cep;
  String? district;

  @override
  String toString() {
    return 'Address{uf: $uf, city: $city, cep: $cep, district: $district}';
  }
}
