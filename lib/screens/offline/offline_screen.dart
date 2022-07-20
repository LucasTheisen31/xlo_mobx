import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/stores/connectivity_store.dart';

class OfflineScreen extends StatefulWidget {
  const OfflineScreen({Key? key}) : super(key: key);

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  //acessando uma instancia de ConnectivityStore atravez do GetIt, que da acesso a objetos de qualquer lugar do app
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  @override
  void initState() {
    super.initState();

    //reaction para quando connectivityStore.connected (observable connected mudar para true ou seja quando conectar a rede) sair desta pagina
    when((_) => connectivityStore.connected, () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    //WillPopScope onWillPop: () =>  Future.value(false), para ignorar o botao de voltar pagina (Ele nos dá controle sobre a ação do botão Voltar)
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: Text('XLO'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sem conexão com a internet!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              Icon(
                Icons.cloud_off,
                color: Colors.white,
                size: 150,
              ),
              Text(
                'Por favor, verifique a sua conexão com a internet para continuar utilizando o app.',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
