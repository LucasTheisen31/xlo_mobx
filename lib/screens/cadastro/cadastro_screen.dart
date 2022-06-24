import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo_mobx/screens/cadastro/coponents/field_title.dart';

class CadastroScreen extends StatelessWidget {
  const CadastroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            child: Padding(
              //espaçamento interno do card
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FieldTitle(
                      title: 'Nome',
                      subTitle: 'Como aparecerá em seus anuncios'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(80, 160, 191, 1),
                        ),
                      ),
                      isDense: true,
                      hintText: 'Exemplo: Lucas T.',
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FieldTitle(
                      title: 'E-mail',
                      subTitle: 'Enviaremos um e-mail de confirmação'),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(80, 160, 191, 1),
                        ),
                      ),
                      isDense: true,
                      hintText: 'Exemplo: lucas@homail.com',
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FieldTitle(title: 'Celular', subTitle: 'Proteja sua conta'),
                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(80, 160, 191, 1),
                        ),
                      ),
                      isDense: true,
                      hintText: '(45) 99999-9999',
                    ),
                    inputFormatters: [
                      //WhitelistingTextInputFormatter.digirsOnly,
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FieldTitle(
                      title: 'Senha',
                      subTitle: 'Letras, numeros e caracteres especiais'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      hintText: '',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(80, 160, 191, 1),
                        ),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FieldTitle(
                      title: 'Confirmar senha', subTitle: 'Repita a senha'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      hintText: '',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(80, 160, 191, 1),
                        ),
                      ),
                    ),
                    obscureText: true,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 12),
                    height: 40,
                    child: RaisedButton(
                      child: Text('CADASTRAR'),
                      elevation: 0,
                      textColor: Colors.white,
                      color: Color.fromRGBO(80, 160, 191, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Divider(
                    color: Colors.grey[700],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          'Já tem conta?',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromRGBO(80, 160, 191, 1),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
