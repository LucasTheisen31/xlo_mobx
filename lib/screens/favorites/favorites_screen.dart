import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/components/empty_card.dart';
import 'package:xlo_mobx/stores/favorite_store.dart';

import 'components/favorite_tile.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key, this.hideDrawer = false}) : super(key: key);

  final bool hideDrawer;

  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
      ),
      drawer: hideDrawer ? null : CustomDrawer(),
      body: Observer(
        builder: (context) {
          if (favoriteStore.favoriteList.isEmpty) {
            return EmptyCard(text: "Nehum anúncio favoritado.");
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(2),
              itemCount: favoriteStore.favoriteList.length,
              itemBuilder: (context, index) =>
                  FavoriteTile(anuncio: favoriteStore.favoriteList[index]),
            );
          }
        },
      ),
    );
  }
}
