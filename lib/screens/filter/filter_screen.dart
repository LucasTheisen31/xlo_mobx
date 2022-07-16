import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/screens/filter/components/orderby_field.dart';
import 'package:xlo_mobx/screens/filter/components/price_range_field.dart';
import 'package:xlo_mobx/stores/filter_store.dart';
import 'package:xlo_mobx/stores/home_store.dart';

import 'components/section_title.dart';
import 'components/vendor_type_field.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({Key? key}) : super(key: key);

  //para dar acesso a instancia da FilterStore
  final filterStore = GetIt.I<HomeStore>().cloneFilterStore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrar Busca'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SectionTitle(title: 'Localização'),
                  OrderByField(filterStore: filterStore),
                  PriceRangeField(filterStore: filterStore),
                  VendorTypeField(filterStore: filterStore),
                  Observer(
                    builder: (context) => Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      height: 50,
                      child: ElevatedButton(
                        onPressed: filterStore.isFormValid
                            ? () {
                                filterStore.save();
                                //sai da tela
                                Navigator.of(context).pop();
                              }
                            : null,
                        child: Text(
                          'Filtrar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Theme.of(context).primaryColor,
                          onSurface: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
