import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/repositorios/parse_errors.dart';
import 'package:xlo_mobx/repositorios/table_keys.dart';

import '../models/category.dart';

class CategoryRepositorio {
  //função para retornar os registros da tabela 'Categorias' no ParseServer (vai traser todos as categorias ordenando pela coluna 'descricao')
  getList() async {
    //criando a query (consulta)
    final queryBuilder = QueryBuilder(ParseObject(keyCategoryTable))
      ..orderByAscending(keyCategoryDescription);
    //executando a busca e armazendando o resultado em response
    final response = await queryBuilder.query();

    if (response.success) {
      //se executar a busca com sucesso temos que instanciar objetos do tipo categorias com os dados que foram buscados no banco, entao chamamos o metodo fromParse da classe Category para fazer isso
      //.tolist para criar uma lista com todos estes objetos instanciados
      response.results!.map((e) => Category.fromParse(e)).toList();
    } else {
      //lança uma exeção passando o codigo do erro (ParseErrors.getDescription é a classe que criamos que contem a lista dos erros que o parse pode ter)
      throw ParseErrors.getDescription(response.error!.code);
    }
  }
}
