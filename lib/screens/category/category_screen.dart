import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/stores/category_store.dart';

import '../../models/category.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key, this.selected, this.showAll = true})
      : super(key: key);
  //CategoryStore atravez do GetIt pode ser acessado de qualquer local desta forma
  final CategoryStore categoryStore = GetIt.I<CategoryStore>();
  //categoria selecionada
  final Category? selected;
  //bool se é pra exibir todas as categorias ou nao
  final bool showAll;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.fromLTRB(32, 12, 32, 32),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
          child: Observer(
            builder: (context) {
              if (categoryStore.error != null) {
                return ErrorBox(message: categoryStore.error);
              } else if (categoryStore.categoryList.isEmpty) {
                //se a lista de categoria estiver vazia
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else {
                //é prara exibir todas as categorias? (categories recebe a lista de acordo)
                final categories = showAll
                    ? categoryStore.allCategoryList
                    : categoryStore.categoryList;
                return ListView.separated(
                  itemCount: categories.length,
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 0.1,
                      color: Colors.grey,
                    );
                  },
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //retorna passando a categoria
                        Navigator.of(context).pop(categories[index]);
                      },
                      child: Container(
                        height: 50,
                        color: categories[index].id == selected?.id
                            ? Color.fromRGBO(80, 160, 191, 1).withAlpha(50)
                            : null,
                        alignment: Alignment.center,
                        child: Text(
                          categories[index].description,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: categories[index].id == selected?.id
                                ? FontWeight.bold
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
