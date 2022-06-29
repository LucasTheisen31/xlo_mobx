import 'dart:io';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceModal extends StatelessWidget {
  const ImageSourceModal({Key? key, required this.onImageSelected})
      : super(key: key);

  //********** funcao CallBack que vai retornar a imagem no formato File
  final Function(File) onImageSelected;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            onTap: getFromCamera,
            leading: Icon(Icons.camera_alt),
            title: Text('Camera'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: getFromGallery,
            leading: Icon(Icons.image),
            title: Text('Galeria'),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      );
    } else {
      return CupertinoActionSheet(
        actions: [
          CupertinoListTile(
            onTap: getFromCamera,
            leading: Icon(Icons.camera_alt),
            title: Text('Camera'),
          ),
          CupertinoListTile(
            onTap: getFromGallery,
            leading: Icon(Icons.image),
            title: Text('Galeria'),
          ),
        ],
      );
    }
  }

  //funcao chamada quando selecionar a opçao da camera (esta funcao vai pegar uma imagem tirada com a camera)
  Future<void> getFromCamera() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File? image = File(pickedFile.path);
      //chama a funcao para cortar a imagem
      imageSelected(image);
    } else {
      return;
    }
  }

  //funcao chamada quando selecionar a opçao da galeria (esta funcao vai pegar uma imagem da galeria)
  Future<void> getFromGallery() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File? image = File(pickedFile.path);
      //chama a funcao para cortar a imagem
      imageSelected(image);
    } else {
      return;
    }
  }

  Future<void> imageSelected(File? image) async {
    if (image != null) {
      //ImageCropper é um plugin para cortar imagens, apos cortar a imagem ele retorna a imagem
      File? croppedImage =
          await ImageCropper().cropImage(sourcePath: image.path);
      androidUiSettings:
      AndroidUiSettings(
        toolbarTitle: 'Editar Imagen',
        toolbarColor: Colors.blue,
        toolbarWidgetColor: Colors.white,
      );
      IOSUiSettings(
        title: 'Editar Imagem',
        cancelButtonTitle: 'Cancelar',
        doneButtonTitle: 'Concluir',
      );

      //chama a funcao de callback (onImageSelected) para retornar a imagem
      onImageSelected(croppedImage!);
    }
  }
}
