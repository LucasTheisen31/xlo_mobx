import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key? key}) : super(key: key);

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //PageView = Uma lista rolável que funciona página por página.
      body: PageView(
        scrollDirection: Axis.horizontal,
        //nao deixa deslizar as paginas arrastando com o dedo
        physics: NeverScrollableScrollPhysics(),
        //controller que vai ser usado para trocar as paginas
        controller: pageController,
        children: [
          //5 paginas
          HomeScreen(),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.purple,
          ),
          Container(
            color: Colors.brown,
          ),
        ],
      ),
    );
  }
}
