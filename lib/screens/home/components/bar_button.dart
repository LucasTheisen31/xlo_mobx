import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  BarButton(
      {Key? key,
      required this.text,
      required this.decoration,
      required this.onTap})
      : super(key: key);

  final String text;
  final BoxDecoration decoration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: decoration,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
