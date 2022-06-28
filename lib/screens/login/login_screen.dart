import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/screens/cadastro/cadastro_screen.dart';
import 'package:xlo_mobx/stores/cadastro_store.dart';
import 'package:xlo_mobx/stores/login_store.dart';

import '../../components/custom_drawer/custom_drawer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  LoginStore loginStore = LoginStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrar'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(80, 160, 191, 1),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                //menor altura possivel
                mainAxisSize: MainAxisSize.min,
                //maior largura possivel
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Acessar com E-mail:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Observer(
                    builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ErrorBox(
                        message: loginStore.error,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 4, top: 8),
                    child: Text(
                      'E-mail',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Observer(
                    builder: (context) => TextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: loginStore.setEmail,
                      enabled: !loginStore.loading,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        errorText: loginStore.emailError,
                        isDense: true,
                        hintText: '',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(80, 160, 191, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Senha',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromRGBO(80, 160, 191, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Observer(
                    builder: (context) => TextField(
                      onChanged: loginStore.setPass,
                      enabled: !loginStore.loading,
                      decoration: InputDecoration(
                        errorText: loginStore.passwordError,
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
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Observer(
                    builder: (context) => Container(
                      margin: EdgeInsets.only(top: 20, bottom: 12),
                      height: 40,
                      child: RaisedButton(
                        child: loginStore.loading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text('ENTRAR'),
                        elevation: 0,
                        textColor: Colors.white,
                        color: Color.fromRGBO(80, 160, 191, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        disabledColor:
                            Color.fromRGBO(80, 160, 191, 1).withAlpha(120),
                        onPressed: loginStore.loginPressed,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey[700],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Wrap(
                      //Wrap se nao couber na mesma linha vai quebrar para a linha de baixo
                      //vai colocar no centro o texto quebrado
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          'Não tem uma conta?',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CadastroScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Cadastre-se',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                              color: Color.fromRGBO(80, 160, 191, 1),
                            ),
                          ),
                        )
                      ],
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
