import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/category/category_screen.dart';
import 'package:xlo_mobx/stores/category_store.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class CategoryField extends StatelessWidget {
  const CategoryField({Key? key, required this.createStore}) : super(key: key);

  final CreateStore createStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Column(
          children: [
            ListTile(
              title: createStore.category == null
                  ? Text(
                      'Categoria*',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    )
                  : Text(
                      'Categoria*',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
              subtitle: createStore.category == null
                  ? null
                  : Text(
                      '${createStore.category!.description}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () async {
                final category = await showDialog(
                  context: context,
                  builder: (context) => CategoryScreen(
                    showAll: false,
                    selected: createStore.category,
                  ),
                );
                if (category != null) {
                  createStore.setCategory(category);
                }
              },
            ),
            if (createStore.categoryError != null)
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                child: Text(
                  createStore.categoryError!,
                  style: TextStyle(color: Colors.red, fontSize: 13),
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
