import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/stores/home_store.dart';
import '../../components/empty_card.dart';
import 'components/anuncio_tile.dart';
import 'components/create_anuncio_button.dart';
import 'components/search_dialog.dart';
import 'components/top_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //para dar acesso a instancia da HomeStore
  final homeStore = GetIt.I<HomeStore>();

  //controlador para a listView pois vamos usar animação
  ScrollController scrollController = ScrollController();

  openSearch(BuildContext context) async {
    final search = await showDialog(
      context: context,
      builder: (context) {
        return SearchDialog(
          currentSearch: homeStore.search,
        );
      },
    );
    if (search != null) {
      homeStore.setSearch(search);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //drawer customizado usado em todas as telas, por isso ele é externo
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Observer(
            builder: (context) {
              if (homeStore.search.isEmpty) {
                return Container();
              } else {
                return GestureDetector(
                  //LayoutBuilder constrói uma árvore de widgets que pode depender do tamanho do widget pai.
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        //maior largura possivel
                        width: constraints.biggest.width,
                        child: Text(
                          homeStore.search,
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    openSearch(context);
                  },
                );
              }
            },
          ),
          backgroundColor: Color.fromRGBO(80, 160, 191, 1),
          actions: [
            Observer(
              builder: (context) {
                if (homeStore.search.isEmpty) {
                  return IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      openSearch(context);
                    },
                  );
                } else {
                  return IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      homeStore.setSearch('');
                    },
                  );
                }
              },
            )
          ],
        ),
        body: Column(
          children: [
            TopBar(),
            Expanded(
              child: Stack(
                children: [
                  Observer(builder: (_) {
                    if (homeStore.error != null)
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.error,
                              color: Colors.white,
                              size: 100,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Ocorreu um erro!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      );
                    if (homeStore.showProgress)
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      );
                    if (homeStore.listaAnuncio.isEmpty)
                      return EmptyCard(
                        text: 'Nenhum anúncio encontrado.',
                      );
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: homeStore.itemCount,
                      itemBuilder: (_, index) {
                        if (index < homeStore.listaAnuncio.length)
                          return AnuncioTile(
                              anuncio: homeStore.listaAnuncio[index]);

                        homeStore.nextPage();
                        return Container(
                          height: 10,
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.purple),
                          ),
                        );
                      },
                    );
                  }),
                  Positioned(
                    bottom: -50,
                    left: 0,
                    right: 0,
                    child:
                        CreateAnuncioButton(scrollController: scrollController),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
