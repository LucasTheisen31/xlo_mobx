import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/page_section.dart';

import 'custom_drawer_header.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ClipRRect para deixar o drawer arredondado - Um widget que recorta seu filho usando um retângulo arredondado.
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(50)),
      child: Drawer(
        //largura de 60% da tela
        width: MediaQuery.of(context).size.width * 0.65,
        //ListView para colocar os widgets um em cima do outro(igual uma coluna) mas que possa rolar
        child: ListView(
         children: [
           CustomDrawerHeader(),
           PageSection(),
         ],
        ),
      ),
    );
  }
}
