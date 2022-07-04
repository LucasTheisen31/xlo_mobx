import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/cep_store.dart';

class CepField extends StatelessWidget {
  CepField({Key? key}) : super(key: key);

  final CepStore cepStore = CepStore();
  final contentPadding = EdgeInsets.fromLTRB(16, 10, 12, 10);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          onChanged: cepStore.setCep,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CepInputFormatter(),
          ],
          decoration: InputDecoration(
            label: Text('CEP*'),
            labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.grey,
            ),
            contentPadding: contentPadding,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(80, 160, 191, 1),
              ),
            ),
          ),
        ),
        Observer(
          builder: (context) {
            if (cepStore.address == null &&
                cepStore.error == null &&
                cepStore.loading == false) {
              return Container();
            } else if (cepStore.address == null &&
                cepStore.error == null &&
                cepStore.loading == true) {
              return const LinearProgressIndicator(
                color: Colors.red,
              );
            } else if (cepStore.error != null) {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                color: Color.fromRGBO(80, 160, 191, 1).withAlpha(100),
                height: 50,
                child: Text(
                  cepStore.error!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              );
            } else {
              final a = cepStore.address;
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                color: Color.fromRGBO(80, 160, 191, 1).withAlpha(100),
                height: 50,
                child: Text(
                  'Localização: ${a?.district}, ${a!.city!.nome}, ${a.uf!.sigla}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
