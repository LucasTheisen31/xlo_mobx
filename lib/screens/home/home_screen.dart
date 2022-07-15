import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/stores/home_store.dart';
import 'components/anuncio_tile.dart';
import 'components/search_dialog.dart';
import 'components/top_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  //para dar acesso a instancia da HomeStore
  final homeStore = GetIt.I<HomeStore>();

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
              child: Observer(
                builder: (context) {
                  if (homeStore.loading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                  if (homeStore.error != null) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.white,
                              size: 100,
                            ),
                            SizedBox(
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
                            Text(
                              'Mensagem de erro: ${homeStore.error}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  if (homeStore.listaAnuncio.isEmpty) {
                    return Center(
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              color: Colors.white,
                              size: 100,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Nenhum anúncio encontrado!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: homeStore.listaAnuncio.length,
                      itemBuilder: (cotext, index) {
                        return AnuncioTile(
                            anuncio: homeStore.listaAnuncio[index]);
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
