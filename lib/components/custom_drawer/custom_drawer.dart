import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/page_section.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //largura de 60% da tela
      width: MediaQuery.of(context).size.width * 0.6,
      //ListView para colocar os widgets um em cima do outro(igual uma coluna) mas que possa rolar
      child: ListView(
       children: [
         PageSection(),
       ],
      ),
    );
  }
}
