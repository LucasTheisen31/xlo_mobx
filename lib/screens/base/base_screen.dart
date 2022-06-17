import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../stores/page_store.dart';
import '../home/home_screen.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  final PageController pageController = PageController();
  //acessando uma instancia da classe PageStore atravez do GetIt, que da acesso a objetos de qualquer lugar do app
  final PageStore pageStore = GetIt.I<PageStore>();


  @override
  void initState() {
    super.initState();
    /*autorun é uma reação que é executada sempre que um observable que esteja dentro dele seja lido ou modificado
        sempre que tiver uma alteração o autorun vai executar a função,
        reaction é como autorun, mas oferece um controle mais refinado sobre quais observáveis serão rastreados.
        São necessárias duas funções: a primeira, função de dados , é rastreada e retorna os dados que são usados como entrada para a segunda, função de efeito
        */
    reaction((_) => pageStore.page, (page) {
      pageController.jumpToPage(page as int);
    });
  }

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
