import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/screens/category/category_screen.dart';
import 'package:xlo_mobx/stores/home_store.dart';

import 'bar_button.dart';

class TopBar extends StatelessWidget {
  TopBar({Key? key}) : super(key: key);
  //para dar acesso a instancia da HomeStore
  final homeStore = GetIt.I<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Observer(
          builder: (context) => BarButton(
            //se tiver alguma categoria selecionada exibe ela, senao exibe o texto como sendo Categorias
            text: homeStore.category?.description ?? 'Categorias',
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            onTap: () async {
              final category = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(
                    selected: homeStore.category,
                    showAll: true,
                  ),
                ),
              );
              if (category != null) {
                //seta a categoria selecionada na HomeStore
                homeStore.setCategory(category);
              }
            },
          ),
        ),
        BarButton(
          text: 'Filtros',
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade400,
              ),
              left: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
