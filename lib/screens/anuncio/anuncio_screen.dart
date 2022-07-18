import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/models/anuncio.dart';
import 'package:xlo_mobx/screens/anuncio/components/main_panel.dart';

import 'components/botton_bar.dart';
import 'components/description_panel.dart';
import 'components/location_panel.dart';
import 'components/user_panel.dart';

class AnuncioScreen extends StatelessWidget {
  const AnuncioScreen({Key? key, required this.anuncio}) : super(key: key);

  final Anuncio anuncio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Anúncio'),
      ),
      body: Stack(
        //Stack pois vamos sobrepor Widgets (a BottonBar vai apareer por cima da ListView)
        children: [
          ListView(
            //ListView pois queremos rolar a tela
            children: [
              Container(
                height: 280,
                child: Carousel(
                  images: anuncio.images!
                      .map(
                        (url) => Image.network(url),
                      )
                      .toList(),
                  dotSize: 4,
                  dotBgColor: Colors.transparent,
                  dotColor: Theme.of(context).primaryColor,
                  autoplay: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MainPanel(anuncio: anuncio),
                    Divider(
                      thickness: 1,
                    ),
                    DescriptionPanel(anuncio: anuncio),
                    Divider(
                      thickness: 1,
                    ),
                    LocationPanel(anuncio: anuncio),
                    Divider(
                      thickness: 1,
                    ),
                    UserPanel(anuncio: anuncio),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height:
                          anuncio.status == AnuncioStatus.PENNDING ? 16 : 110,
                    )
                  ],
                ),
              )
            ],
          ),
          BottonBar(anuncio: anuncio),
        ],
      ),
    );
  }
}
