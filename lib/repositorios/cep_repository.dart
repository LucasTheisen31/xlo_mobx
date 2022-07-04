import 'package:dio/dio.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/repositorios/ibge_repository.dart';

class CepRepository {
  Future<Address?> getAddressFromApi(String? cep) async {
    //primeiro verificar se o cep passado nao é vazio
    if (cep == null || cep.isEmpty) return Future.error('CEP Inválido');

    //remove o ponto e o traço do cep pais a api necessita so numeros (qualquer caracter que nao seja de 0 - 9 substitui por um '')
    final clearCep = cep.replaceAll(RegExp('[^0-9]'), '');

    //se o cep ja limpo nao possuir 8 numeros
    if (clearCep.length != 8) return Future.error('CEP Inválido');

    //armazena o endereço de acesso para pegar os dados no formato json do cep passado
    final endpoint = 'https://viacep.com.br/ws/$clearCep/json/';

    try {
      //armazena o mapa com os dados do cep
      final response = await Dio().get<Map>(endpoint);
      //se o cep nao existe
      if (response.data!.containsKey('erro') && response.data!['erro']) {
        return Future.error('CEP Inválido');
      }
      //pega a lista de UF(estados) do Brasil
      final ufList = await IBGERepository().getUfList();

      //retorna um objeto Address com os dados do endereço
      return Address(
        cep: response.data!['cep'],
        district: response.data!['bairro'],
        city: City(nome: response.data!['localidade']),
        uf: ufList.firstWhere((uf) => uf.sigla == response.data!['uf']),
      );
    } catch (e) {
      return Future.error('Falha ao buscar CEP');
    }
  }
}
