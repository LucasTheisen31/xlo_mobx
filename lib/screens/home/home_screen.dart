import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //drawer customizado usado em todas as telas, por isso ele é externo
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(80, 160, 191, 1),
        ),
      ),
    );
  }
}
