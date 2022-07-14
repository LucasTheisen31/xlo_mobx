import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/stores/home_store.dart';
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
          ],
        ),
      ),
    );
  }
}
