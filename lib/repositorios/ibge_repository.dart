import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/city.dart';
import '../models/uf.dart';

class IBGERepository {
  //metodo para retornar os estados
  Future<List<UF>> getUfList() async {
    // Obtem shared preferences. SharedPreferences para armazenar dados localmente
    final preferences = await SharedPreferences.getInstance();

    //se a lista dos estados ja esta armazenada localmente no shared preferences
    if (preferences.containsKey('UF_LIST')) {
      print("Armazenado Localmente");
      //le o que esta salvo localmente
      final j = json.decode(preferences.get('UF_LIST') as String);
      //transforma essa lista em objetos UF e a retorna
      return j.map<UF>((e) => UF.fromJason(e)).toList()
        ..sort((UF a, UF b) =>
            a.nome!.toLowerCase().compareTo(b.nome!.toLowerCase()));
    }
    //se a lista de estados nao estiver armazenada localmente
    //url onde vamos buscar os dados (json)
    print("Nao Esta Armazenado Localmente");
    const endpoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';
    try {
      //obtem a lista (json) de estados do endereço acima (converte em uma lista)
      final response = await Dio().get<List>(endpoint);

      //pega a lista obtida pelo Dio (json) e converte ele em uma string e salva localmente na Uf_LIST
      preferences.setString('UF_LIST', jsonEncode(response.data));

      //retorna uma lista de objetos tipo UF a partir da lista (json) de estados obtidos acima (retorna Lista de objetos UF ordenada)
      return response.data!.map<UF>((e) => UF.fromJason(e)).toList()
        ..sort(
            (a, b) => a.nome!.toLowerCase().compareTo(b.nome!.toLowerCase()));
    } on DioError {
      return Future.error('Falha ao obter a lista dos estados');
    }
  }

  //recebe um estado com paramentro e rotorna somente as cidades deste estado.
  Future<List<City>> getCityListFromApi(UF uf) async {
    //url onde vamos buscar os dados (json)
    final String endpoint =
        'http://servicodados.ibge.gov.br/api/v1/localidades/estados/${uf.id}/municipios';

    try {
      //obtem a lista minicipios do endereço acima (converte em uma lista)
      final response = await Dio().get<List>(endpoint);

      //retorna uma lista de objetos tipo City a partir da lista (json) de cidades obtidos acima (retorna Lista de objetos City ordenada)
      return response.data!.map<City>((e) => City.fromJason(e)).toList()
        ..sort(
            (a, b) => a.nome!.toLowerCase().compareTo(b.nome!.toLowerCase()));
    } on DioError {
      return Future.error('Falha ao obter a lista das cidades');
    }
  }
}
