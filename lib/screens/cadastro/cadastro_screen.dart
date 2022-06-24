import 'package:flutter/material.dart';

class CadastroScreen extends StatelessWidget {
  const CadastroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
      ),
    );
  }
}
