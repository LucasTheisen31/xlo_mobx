import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/screens/account/account_screen.dart';
import 'package:xlo_mobx/screens/create_anuncio/create_anuncio_screen.dart';
import 'package:xlo_mobx/screens/favorites/favorites_screen.dart';
import 'package:xlo_mobx/stores/connectivity_store.dart';

import '../../stores/page_store.dart';
import '../home/home_screen.dart';
import '../offline/offline_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();
  //acessando uma instancia da classe PageStore atravez do GetIt, que da acesso a objetos de qualquer lugar do app
  final PageStore pageStore = GetIt.I<PageStore>();
  //acessando uma instancia de ConnectivityStore atravez do GetIt, que da acesso a objetos de qualquer lugar do app
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

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

    /*autorun é uma reação que é executada sempre que um observable que esteja dentro dele seja lido ou modificado
    sempre que tiver uma alteração o autorun vai executar a função. Ou seja vai ficar observando o status da conexao com a rede*/
    autorun((_) {
      //quando o observable 'connected' for false vai bloquear a tela. Ou seja quando perder conexa com a rede vai bloquear a tela
      if (!connectivityStore.connected) {
        Future.delayed(Duration(milliseconds: 50)).then((value) => showDialog(
              context: context,
              builder: (context) => OfflineScreen(),
            ));
      }
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
          //0 - Anuncios
          HomeScreen(),
          //1 - Inserir Anuncios
          CreateAnuncioScreen(),
          //2
          Container(
            color: Colors.yellow,
          ),
          //3
          FavoritesScreen(),
          //4
          AccountScreen()
        ],
      ),
    );
  }
}
