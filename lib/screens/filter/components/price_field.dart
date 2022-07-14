import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceField extends StatelessWidget {
  const PriceField(
      {Key? key,
      required this.label,
      required this.onChanged,
      required this.initialValue})
      : super(key: key);

  final String label;
  final Function(int?) onChanged;
  final int? initialValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          prefix: Text('R\$ '),
          labelText: label,
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
          isDense: true,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          RealInputFormatter(centavos: false),
        ],
        keyboardType: TextInputType.number,
        onChanged: (text) {
          onChanged(int.tryParse(text.replaceAll('.', '')));
        },
        initialValue: initialValue?.toString(),
      ),
    );
  }
}
