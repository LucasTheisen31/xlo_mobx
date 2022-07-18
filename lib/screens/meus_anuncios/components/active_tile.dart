import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/anuncio.dart';
import 'package:xlo_mobx/screens/anuncio/anuncio_screen.dart';
import 'package:xlo_mobx/screens/create_anuncio/create_anuncio_screen.dart';

import '../../../stores/meus_anuncios_store.dart';

class ActiveTile extends StatelessWidget {
  ActiveTile({Key? key, required this.anuncio, required this.meusAnunciosStore})
      : super(key: key);

  final Anuncio anuncio;

  final MeusAnunciosStore meusAnunciosStore;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar', iconData: Icons.edit),
    MenuChoice(index: 1, title: 'Já vendi', iconData: Icons.thumb_up),
    MenuChoice(index: 2, title: 'Excluir', iconData: Icons.delete)
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AnuncioScreen(anuncio: anuncio),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: Container(
          height: 80,
          child: Row(
            children: [
              SizedBox(
                height: 135,
                width: 127,
                child: CachedNetworkImage(
                  imageUrl: anuncio.images!.first,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        anuncio.title!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        anuncio.price!.formattedMoney(),
                        style: const TextStyle(fontWeight: FontWeight.w300),
                      ),
                      Text(
                        '${anuncio.views} visitas',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  PopupMenuButton<MenuChoice>(
                    onSelected: (e) {
                      switch (e.index) {
                        case 0:
                          editAnuncio(context);
                          break;
                        case 1:
                          soldAnuncio(context);
                          break;
                        case 2:
                          deleteAnuncio(context);
                          break;
                        default:
                      }
                    },
                    itemBuilder: (context) {
                      return choices
                          .map(
                            (e) => PopupMenuItem<MenuChoice>(
                              value: e,
                              child: Row(
                                children: [
                                  Icon(
                                    e.iconData,
                                    size: 20,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Text(
                                    e.title,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> soldAnuncio(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Vendido'),
        content: Text('Confirmar a venda de ${anuncio.title}?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Não'),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          TextButton(
            onPressed: () {
              meusAnunciosStore.soldAnuncio(anuncio);
              Navigator.of(context).pop();
            },
            child: const Text('Sim'),
            style: TextButton.styleFrom(primary: Colors.red),
          ),
        ],
      ),
    );
  }

  Future<void> deleteAnuncio(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir'),
        content: Text('Confirmar a exclusão de ${anuncio.title}?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Não'),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          TextButton(
            onPressed: () {
              meusAnunciosStore.deleteAnuncio(anuncio);
              Navigator.of(context).pop();
            },
            child: const Text('Sim'),
            style: TextButton.styleFrom(primary: Colors.red),
          ),
        ],
      ),
    );
  }

  Future<void> editAnuncio(BuildContext context) async {
    final success = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateAnuncioScreen(anuncio: anuncio),
      ),
    );
    if (success != null && success) {
      meusAnunciosStore.refresh();
    }
  }
}

class MenuChoice {
  MenuChoice(
      {required this.index, required this.title, required this.iconData});

  final int index;
  final String title;
  final IconData iconData;
}
