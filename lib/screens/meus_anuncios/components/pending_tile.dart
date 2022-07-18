import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/screens/anuncio/anuncio_screen.dart';

import '../../../models/anuncio.dart';

class PendingTile extends StatelessWidget {
  const PendingTile({Key? key, required this.anuncio}) : super(key: key);

  final Anuncio anuncio;

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
        clipBehavior: Clip.antiAliasWithSaveLayer,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Theme.of(context).primaryColor,
                            size: 15,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'AGUARDANDO PUBLICAÇÃO',
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
