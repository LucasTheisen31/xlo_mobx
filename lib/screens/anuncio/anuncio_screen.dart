import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/models/anuncio.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/screens/anuncio/components/main_panel.dart';
import 'package:xlo_mobx/stores/favorite_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import 'components/botton_bar.dart';
import 'components/description_panel.dart';
import 'components/location_panel.dart';
import 'components/user_panel.dart';

class AnuncioScreen extends StatelessWidget {
  AnuncioScreen({Key? key, required this.anuncio}) : super(key: key);

  final Anuncio anuncio;
  //para dar acesso ao UserManageStore atravez do getIt ou seja é uma unica instancia pra o aplicativo
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  //para dar acesso ao FavoriteStore atravez do getIt ou seja é uma unica instancia pra o aplicativo
  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Anúncio'),
        actions: [
          if (anuncio.status == AnuncioStatus.ACTIVE &&
              userManagerStore.isLoggedIn)
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
                favoriteStore.toggleFavorite(anuncio);
              },
            ),
        ],
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
