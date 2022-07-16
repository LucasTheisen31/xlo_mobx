import 'package:flutter/material.dart';
import 'package:xlo_mobx/models/anuncio.dart';

class LocationPanel extends StatelessWidget {
  const LocationPanel({Key? key, required this.anuncio}) : super(key: key);

  final Anuncio anuncio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 12),
          child: Text(
            'Localização',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('CEP'),
                  SizedBox(
                    height: 12,
                  ),
                  Text('Município'),
                  SizedBox(
                    height: 12,
                  ),
                  Text('Bairro'),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(anuncio.address!.cep!),
                  SizedBox(
                    height: 12,
                  ),
                  Text(anuncio.address!.city!.nome!),
                  SizedBox(
                    height: 12,
                  ),
                  Text(anuncio.address!.district!),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
