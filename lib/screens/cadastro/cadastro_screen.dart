import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/cadastro/coponents/field_title.dart';

import '../../components/error_box.dart';
import '../../stores/cadastro_store.dart';

class CadastroScreen extends StatelessWidget {
  CadastroScreen({Key? key}) : super(key: key);

  CadastroStore cadastroStore = CadastroStore();

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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Observer(
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ErrorBox(
                              message: cadastroStore.error,
                            ),
                          );
                        },
                      ),
                      FieldTitle(
                        title: 'Nome',
                        subTitle: 'Como aparecerá em seus anúncios.',
                      ),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !cadastroStore.loading,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(80, 160, 191, 1),
                                  width: 2,
                                ),
                              ),
                              hintText: 'Exemplo: Lucas T.',
                              isDense: true,
                              errorText: cadastroStore.nameError),
                          onChanged: cadastroStore.setName,
                        );
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      FieldTitle(
                        title: 'E-mail',
                        subTitle: 'Enviaremos um e-mail de confirmação.',
                      ),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !cadastroStore.loading,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(80, 160, 191, 1),
                                  width: 2,
                                ),
                              ),
                              hintText: 'Exemplo: lucas@gmail.com',
                              isDense: true,
                              errorText: cadastroStore.emailError),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          onChanged: cadastroStore.setEmail,
                        );
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      FieldTitle(
                        title: 'Celular',
                        subTitle: 'Proteja sua conta',
                      ),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !cadastroStore.loading,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(80, 160, 191, 1),
                                  width: 2,
                                ),
                              ),
                              hintText: '(99) 99999-9999',
                              isDense: true,
                              errorText: cadastroStore.phoneError),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            //WhitelistingTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter()
                          ],
                          onChanged: cadastroStore.setPhone,
                        );
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      FieldTitle(
                        title: 'Senha',
                        subTitle: 'Use letras, números e caracteres especiais',
                      ),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !cadastroStore.loading,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(80, 160, 191, 1),
                                  width: 2,
                                ),
                              ),
                              isDense: true,
                              errorText: cadastroStore.pass1Error),
                          obscureText: true,
                          onChanged: cadastroStore.setPass1,
                        );
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      FieldTitle(
                        title: 'Confirmar Senha',
                        subTitle: 'Repita a senha',
                      ),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !cadastroStore.loading,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(80, 160, 191, 1),
                                  width: 2,
                                ),
                              ),
                              isDense: true,
                              errorText: cadastroStore.pass2Error),
                          obscureText: true,
                          onChanged: cadastroStore.setPass2,
                        );
                      }),
                      Observer(builder: (_) {
                        return Container(
                          height: 40,
                          margin: const EdgeInsets.only(top: 20, bottom: 12),
                          child: RaisedButton(
                            color: Color.fromRGBO(80, 160, 191, 1),
                            disabledColor:
                                Color.fromRGBO(80, 160, 191, 1).withAlpha(120),
                            child: cadastroStore.loading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text('CADASTRAR'),
                            textColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: cadastroStore.signUpPressed,
                          ),
                        );
                      }),
                      Divider(
                        color: Colors.grey[700],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Já tem uma conta? ',
                              style: TextStyle(fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: Navigator.of(context).pop,
                              child: Text(
                                'Entrar',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color.fromRGBO(80, 160, 191, 1),
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
