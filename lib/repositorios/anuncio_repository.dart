import 'dart:io';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/anuncio.dart';
import 'package:path/path.dart' as path;
import 'package:xlo_mobx/repositorios/parse_errors.dart';

class AnuncioRepository {
  Future<void> saveAnuncio(Anuncio anuncio) async {
    //chama o metodo para salvar as imagens no parse server e o parse retorna uma lista das imagens no formato ParseFile
    final parseImages = await saveImages(anuncio.images!);
  }

  /* metodo para salvar as imagens no parse server e o parse retorna uma lista das imagens no formato ParseFile.
  Lembrando que este metodo pode receber imagens que ja esta no ParseServer (formato ParseFile) e imagens q ainda nao estão */
  Future<List<ParseFile>> saveImages(List images) async {
    //lista do tipo ParseFile
    final parseImages = <ParseFile>[];

    try {
      //for para percorrer a lista de imagens veriricando cada uma delas
      for (final image in images) {
        if (image is File) {
          //se a imagem for um File precisamos fazer upload desta imagen para o ParseServer (vamos usar o pacote path para pegar o nome do arquivo da imagem)
          final parseFile = ParseFile(image, name: path.basename(image.path));
          final response = await parseFile
              .save(); //salva no ParseServer e obtem a resposta do salvamento
          if (!response.success) {
            //se der errp converte o codigo do erro em uma descricao em portugues usando a classe ParseErrors metodo getDescription
            return Future.error(
                ParseErrors.getDescription(response.error!.code));
          }
          //add o parse file a lista
          parseImages.add(parseFile);
        } else {
          //caso a imagem seja apenas uma url que ja esta no ParseServer
          final parseFile = ParseFile(null); //cria um arquivo parseFile
          //define o nome como o da imagem que esta no ParseServer
          parseFile.name = path.basename(image);
          parseFile.url = image; //define a url da img
          parseImages.add(parseFile); //add o parseFile a lista de img
        }
      }

      return parseImages; //retorna a lista de img

    } catch (e) {
      return Future.error('Falha ao salvar imagens');
    }
  }
}
