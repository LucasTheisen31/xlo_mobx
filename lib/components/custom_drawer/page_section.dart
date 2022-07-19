import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/page_tile.dart';
import 'package:xlo_mobx/screens/login/login_screen.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import '../../stores/page_store.dart';

class PageSection extends StatelessWidget {
  PageSection({Key? key}) : super(key: key);

  //acessando uma instancia da classe PageStore atravez do GetIt, que da acesso a objetos de qualquer lugar do app
  final PageStore pageStore = GetIt.I<PageStore>();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    Future<void> verifyLoginAndSetPage(int page) async {
      //se tiver um usuario logado
      if (userManagerStore.isLoggedIn) {
        //permite ir prara a pagina (1,2,3,4)
        pageStore.setPage(page);
      } else {
        //senao abre a tela de login e aguarda logar
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
        if (result != null && result) {
          pageStore.setPage(page);
        }
      }
    }

    return Column(
      children: [
        PageTile(
          label: 'Anúncios',
          iconData: Icons.list,
          onTap: () {
            pageStore.setPage(0);
          },
          //highlighted vai servir pra dizer se esta selecionado ou nao
          highlighted: pageStore.page == 0,
        ),
        PageTile(
          label: 'Inserir Anúncios',
          iconData: Icons.edit,
          onTap: () {
            verifyLoginAndSetPage(1);
          },
          highlighted: pageStore.page == 1,
        ),
        PageTile(
          label: 'Chat',
          iconData: Icons.chat,
          onTap: () {
            verifyLoginAndSetPage(2);
          },
          highlighted: pageStore.page == 2,
        ),
        PageTile(
          label: 'Favoritos',
          iconData: Icons.favorite,
          onTap: () {
            verifyLoginAndSetPage(3);
          },
          highlighted: pageStore.page == 3,
        ),
        PageTile(
          label: 'Minha Conta',
          iconData: Icons.person,
          onTap: () {
            verifyLoginAndSetPage(4);
          },
          highlighted: pageStore.page == 4,
        ),
      ],
    );
  }
}
