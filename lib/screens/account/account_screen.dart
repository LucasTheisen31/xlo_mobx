import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/favorites/favorites_screen.dart';
import 'package:xlo_mobx/screens/meus_anuncios/meus_anuncios_screen.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../edit_account/edit_account_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha conta'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(
            horizontal: 32,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 140,
                child: Stack(
                  //Stack para poder posicionar os widgets livremente
                  children: [
                    //Align para posicionar o Widget dentro da Stack
                    Align(
                      alignment: Alignment.center,
                      child: Observer(
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              //GetIt.I<UserManagerStore>() para acessar a instancia do usuario logado
                              GetIt.I<UserManagerStore>().user!.name,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              //GetIt.I<UserManagerStore>() para acessar a instancia do usuario logado
                              GetIt.I<UserManagerStore>().user!.email,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditAccountScreen(),
                            ),
                          );
                        },
                        child: Text('EDITAR'),
                        style: TextButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MeusAnunciosScreen(),
                    ),
                  );
                },
                title: Text(
                  'Meus Anúncios',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FavoritesScreen(hideDrawer: true),
                  ));
                },
                title: Text(
                  'Favoritos',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
