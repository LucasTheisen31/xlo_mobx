import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  //no contrutor ja passa a currentSearch (pesquisa atual) para o controller do TextField
  SearchDialog({Key? key, this.currentSearch})
      : controller = TextEditingController(text: currentSearch),
        super(key: key);

  final TextEditingController controller;

  //para armazenar a pesquisa atual
  final currentSearch;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 2,
          left: 2,
          right: 2,
          child: Card(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                ),
                border: InputBorder.none,
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  color: Colors.grey.shade700,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.clear();
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              //foca automaticamente no campo de texto
              autofocus: true,
              //botao de lupa no teclado
              textInputAction: TextInputAction.search,
              //onSubmitted é chamado quando cluca no botao do teclado
              onSubmitted: (text) {
                //fecha o campo de busca retornando o texto do campo
                Navigator.of(context).pop(text);
              },
            ),
          ),
        )
      ],
    );
  }
}
