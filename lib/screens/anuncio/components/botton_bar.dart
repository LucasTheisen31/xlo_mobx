import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xlo_mobx/models/anuncio.dart';

class BottonBar extends StatelessWidget {
  const BottonBar({Key? key, required this.anuncio}) : super(key: key);

  final Anuncio anuncio;

  @override
  Widget build(BuildContext context) {
    //Positioned pois precisamos informar a posicao que ira aparecer, pois este BottonBar é chamado no Stack
    return Positioned(
      /*vai estar a 0 de distancia da area de baixo, zero de distancia da esquerda e zero de distancia da direita*/
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            height: 38,
            margin: const EdgeInsets.symmetric(horizontal: 26),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              color: Theme.of(context).primaryColor,
            ),
            child: Row(
              children: [
                //se nao esta selecionada a opçao de ocultar o telefone ira exibir o botao de ligar
                if (!anuncio.hidePhone!)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        //limpamos o telefone deixando somente numeros
                        final phone = anuncio.user!.phone
                            .replaceAll(RegExp('[^0-9]'), '');
                        //vamos usa ro packeged url_launcher para abrir o telefone
                        launch('tel:$phone');
                      },
                      child: Container(
                        height: 25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.black45,
                            ),
                          ),
                        ),
                        child: Text(
                          'Ligar',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 25,
                      alignment: Alignment.center,
                      child: Text(
                        'Chat',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(249, 249, 249, 1),
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            child: Text(
              '${anuncio.user!.name} (anunciante)',
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
