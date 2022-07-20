import 'package:flutter/material.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/anuncio.dart';

class UserPanel extends StatelessWidget {
  const UserPanel({Key? key, required this.anuncio}) : super(key: key);

  final Anuncio anuncio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 18),
          child: Text(
            'Anunciante',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                anuncio.user!.name!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Anunciante desde: ${anuncio.user!.createdAt!.formattedDate()}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
