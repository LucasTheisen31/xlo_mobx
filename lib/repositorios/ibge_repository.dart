import 'package:dio/dio.dart';

import '../models/uf.dart';

class IBGERepository {
  //metodo para retornar os estados
  Future<List<UF>> getUfListFromApi() async {
    //url onde vamos buscar os dados (json)
    const endpoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

    try {
      //obtem a lista de estados do endereço acima (converte em uma lista)
      final response = await Dio().get<List>(endpoint);

      //retorna uma lista de objetos tipo UF a partir da lista (json) de estados obtidos acima (Lista objetos UF ordenada)
      final ufList = response.data!.map<UF>((e) => UF.fromJason(e)).toList()
        ..sort(
            (a, b) => a.nome!.toLowerCase().compareTo(b.nome!.toLowerCase()));

      return ufList;
    } on DioError {
      return Future.error('Falha ao obter a lista dos estados');
    }
  }

  //recebe um estado com paramentro e rotorna somente as cidades deste estado.
  getCityListFromApi() {}
}
