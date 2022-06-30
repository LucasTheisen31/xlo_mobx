import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo_mobx/stores/create_store.dart';
import '../../components/custom_drawer/custom_drawer.dart';
import 'components/category_field.dart';
import 'components/images_field.dart';

class CreateAnuncioScreen extends StatelessWidget {
  CreateAnuncioScreen({Key? key}) : super(key: key);

  CreateStore createStore = CreateStore();

  final labelStyle = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w800,
    fontSize: 18,
  );

  final contentPadding = EdgeInsets.fromLTRB(16, 10, 12, 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar anuncio'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Card(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          child: Column(
            //menor altura possivel
            mainAxisSize: MainAxisSize.min,
            //maior largura possivel
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ImagesField(createStore: createStore),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Titulo*',
                  labelStyle: labelStyle,
                  contentPadding: contentPadding,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Titulo*',
                  labelStyle: labelStyle,
                  //espacamento dentro do TextFOrmField
                  contentPadding: contentPadding,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descrição*',
                  labelStyle: labelStyle,
                  //espacamento dentro do TextFOrmField
                  contentPadding: contentPadding,
                ),
                maxLines: null,
              ),
              CategoryField(
                createStore: createStore,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'CEP*',
                  labelStyle: labelStyle,
                  //espacamento dentro do TextFOrmField
                  contentPadding: contentPadding,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  //permite somente digitos
                  FilteringTextInputFormatter.digitsOnly,
                  //formata no formado de CEP
                  CepInputFormatter()
                ],
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Preço*',
                  prefixText: 'R\$ ',
                  labelStyle: labelStyle,
                  //espacamento dentro do TextFOrmField
                  contentPadding: contentPadding,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  //permite somente digitos
                  FilteringTextInputFormatter.digitsOnly,
                  //formata no formato de reais (moeda: true, significa que aceita centavos)
                  RealInputFormatter(moeda: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
