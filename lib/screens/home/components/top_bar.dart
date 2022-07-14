import 'package:flutter/material.dart';

import 'bar_button.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BarButton(
          text: 'Categorias',
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
          ),
          onTap: () {},
        ),
        BarButton(
          text: 'Filtros',
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade400,
              ),
              left: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
