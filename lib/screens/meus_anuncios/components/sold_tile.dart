import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/anuncio.dart';
import 'package:xlo_mobx/stores/meus_anuncios_store.dart';

class SoldTile extends StatelessWidget {
  SoldTile({Key? key, required this.anuncio, required this.meusAnunciosStore})
      : super(key: key);

  final Anuncio anuncio;
  //para dar acesso a MeusAnunciosStore
  final MeusAnunciosStore meusAnunciosStore;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  ],
                ),
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    deleteAnuncio(context);
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            )
          ],
        ),
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
}
