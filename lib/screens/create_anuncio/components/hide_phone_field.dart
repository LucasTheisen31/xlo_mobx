import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class HidePhoneField extends StatelessWidget {
  HidePhoneField({Key? key, required this.createStore}) : super(key: key);

  CreateStore createStore;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Row(
          children: [
            Observer(
              builder: (context) => Checkbox(
                value: createStore.hidePhone,
                onChanged: createStore.setHidePhone,
                activeColor: Color.fromRGBO(80, 160, 191, 1),
              ),
            ),
            Expanded(child: Text('Ocultar o meu telefone neste anúncio')),
          ],
        ),
      ),
    );
  }
}
