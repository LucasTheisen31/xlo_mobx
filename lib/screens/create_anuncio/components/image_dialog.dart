import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({Key? key, this.image, required this.onDelete})
      : super(key: key);

  final dynamic image;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.file(image),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              //chama o callback para excluir a imagem
              onDelete();
            },
            textColor: Colors.red,
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
