import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {
  const FieldTitle({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 3,
        bottom: 4,
      ),
      child: Wrap(
        //Wrap ajusta se nao couber na tela
        //WrapCrossAlignment.end alinha oos filhos pela parte de baixo
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          Text(
            '$title',
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: 3,
          ),
          Text(
            '$subTitle',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
