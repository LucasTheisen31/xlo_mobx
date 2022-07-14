import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class OrderByField extends StatelessWidget {
  const OrderByField({Key? key, required this.filterStore}) : super(key: key);

  final FilterStore filterStore;

  //retorna 2 widgets botoes
  Widget buildButtonOption(BuildContext context, String title, OrderBy option) {
    return GestureDetector(
      onTap: () {
        filterStore.setOrderBy(option);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: filterStore.orderBy == option
                ? Theme.of(context).primaryColor
                : Colors.black,
          ),
          borderRadius: BorderRadius.circular(25),
          color: filterStore.orderBy == option
              ? Theme.of(context).primaryColor
              : Colors.transparent,
        ),
        padding: EdgeInsets.symmetric(horizontal: 24),
        //alinha o filho do container no centro
        alignment: Alignment.center,
        child: Text(
          title,
          style: filterStore.orderBy == option
              ? TextStyle(color: Colors.white)
              : TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'Ordenar por'),
        Observer(
          builder: (context) => Row(
            children: [
              buildButtonOption(context, 'Data', OrderBy.DATE),
              SizedBox(
                width: 12,
              ),
              buildButtonOption(context, 'Preço', OrderBy.PRICE),
            ],
          ),
        )
      ],
    );
  }
}
