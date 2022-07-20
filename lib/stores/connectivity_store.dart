import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobx/mobx.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'connectivity_store.g.dart';

class ConnectivityStore = _ConnectivityStore with _$ConnectivityStore;

abstract class _ConnectivityStore with Store {
  //construtor
  _ConnectivityStore() {
    //chama o metodo para verificar o status da conexao com a rede
    _setupListener();
  }

  void _setupListener() {
    //vamos ficar observando onStatusChange e sempre que tiver alguma modificaçao vai chamar a funcao
    InternetConnectionChecker().checkInterval;
    InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          print('**** REDE CONECTADA ****.');
          setConnection(true);
          break;
        case InternetConnectionStatus.disconnected:
          print('**** REDE DESCONECTADA ****.');
          setConnection(false);
          break;
      }
    });
  }

  @observable
  bool connected = true;

  @action
  void setConnection(bool value) => connected = value;
}
