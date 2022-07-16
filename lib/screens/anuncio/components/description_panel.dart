import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:xlo_mobx/models/anuncio.dart';

class DescriptionPanel extends StatelessWidget {
  const DescriptionPanel({Key? key, required this.anuncio}) : super(key: key);

  final Anuncio anuncio;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 18,
          ),
          child: Text(
            'Descrição',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 18),
          //usando package readmore
          child: ReadMoreText(
            anuncio.description!,
            trimLines: 3,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Ver mais',
            trimExpandedText: 'Ver menos',
            colorClickableText: Theme.of(context).primaryColor,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
