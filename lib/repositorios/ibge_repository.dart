import 'package:dio/dio.dart';

import '../models/uf.dart';

class IBGERepository {
  Future<List<UF>> getUfListFromApi() async {
    //url onde vamos buscar os dados (json)
    const endpoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

    try {
      //obtem a lista de estados do endereço acima (converte em uma lista)
      final response = await Dio().get<List>(endpoint);

      //retorna uma lista de objetos tipo UF a partir da lista de estados obtidos acima
      final ufList = response.data!.map<UF>((e) => UF.fromJason(e)).toList();

      return ufList;
    } on DioError {
      return Future.error('Falha ao obter a lista dos estados');
    }
  }

  //recebe um estado com paramentro e rotorna somente as cidades deste estado.
  getCityListFromApi() {}
}
