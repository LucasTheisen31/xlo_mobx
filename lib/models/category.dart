import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/repositorios/table_keys.dart';

class Category {
  //construtor
  Category({required this.id, required this.description});

  //atributos
  late final String id;
  late final String description;

  //metodos
  //metodo para instanciar um objeto categoria a partir dos dados do parse
  Category.fromParse(ParseObject parseObject) {
    id = parseObject.objectId!;
    description = parseObject.get(keyCategoryDescription);
  }

  //toString para quando printarmos uma descrição escrever os dados da categooria
  @override
  String toString() {
    return 'Category{id: $id, description: $description}';
  }
}
