import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/create_anuncio/components/cep_field.dart';
import 'package:xlo_mobx/stores/create_store.dart';
import '../../components/custom_drawer/custom_drawer.dart';
import 'components/category_field.dart';
import 'components/hide_phone_field.dart';
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Card(
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: Column(
                //menor altura possivel
                mainAxisSize: MainAxisSize.min,
                //maior largura possivel
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ImagesField(createStore: createStore),
                  Observer(
                    builder: (context) => TextFormField(
                      onChanged: createStore.setTitle,
                      decoration: InputDecoration(
                        labelText: 'Titulo*',
                        labelStyle: labelStyle,
                        contentPadding: contentPadding,
                        errorText: createStore.titleError,
                      ),
                    ),
                  ),
                  Observer(
                    builder: (context) => TextFormField(
                      onChanged: createStore.setDescription,
                      decoration: InputDecoration(
                        labelText: 'Descrição*',
                        labelStyle: labelStyle,
                        errorText: createStore.descriptionError,
                        //espacamento dentro do TextFOrmField
                        contentPadding: contentPadding,
                      ),
                      maxLines: null,
                    ),
                  ),
                  CategoryField(
                    createStore: createStore,
                  ),
                  CepField(
                    createStore: createStore,
                  ),
                  Observer(builder: (_) {
                    return TextFormField(
                      initialValue: createStore.priceText,
                      onChanged: createStore.setPrice,
                      decoration: InputDecoration(
                        labelText: 'Preço *',
                        labelStyle: labelStyle,
                        contentPadding: contentPadding,
                        //prefixText: 'R\$ ',
                        errorText: createStore.priceError,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        RealInputFormatter(moeda: true),
                      ],
                    );
                  }),
                  HidePhoneField(createStore: createStore),
                  Observer(builder: (_) {
                    return SizedBox(
                      height: 50,
                      child: GestureDetector(
                        onTap: createStore.invalidSendPressed,
                        child: RaisedButton(
                          child: Text(
                            'Enviar',
                            style: TextStyle(fontSize: 18),
                          ),
                          textColor: Colors.white,
                          color: Colors.orange,
                          disabledColor: Colors.orange.withAlpha(120),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: createStore.sendPressed,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
