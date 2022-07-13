import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/repositorios/category_repositorio.dart';
import 'package:xlo_mobx/repositorios/cep_repository.dart';
import 'package:xlo_mobx/repositorios/ibge_repository.dart';
import 'package:xlo_mobx/screens/base/base_screen.dart';
import 'package:xlo_mobx/screens/category/category_screen.dart';
import 'package:xlo_mobx/stores/category_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

// get_it, similar ao Provider que dao acesso a objetos de qualquer local do app.Na sua inicialização você registra todos os objetos que deseja acessar posteriormente assim:
void setupLocators() {
  //essas instancias sao acessiveis de qualquer lugar do app
  //PageStore para poder mudar a pagina de qualquer lugar do app
  GetIt.I.registerSingleton<PageStore>(PageStore());
  //UserManagerStore para ter acesso ao usuario logado de qualquer local do app
  GetIt.I.registerSingleton<UserManagerStore>(UserManagerStore());
  //CategoryStore para ter acesso ao CategoryStore de qualquer local do app
  GetIt.I.registerSingleton<CategoryStore>(CategoryStore());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //inicializando o ParseServer
  await inicializeParse();
  //chamar a funcao setupLocators() para que os objetos contidos nela possam ser acessados de qualquer local do app
  setupLocators();
  runApp(MyApp());

  //cada ParseObject é uma linha em uma tabela ('nomedatabela')..set<tipodovalor>('nomecoluna', 'valor')..set<tipodovalor>('nomecoluna', valor);

  //salvando
/* final category = ParseObject('Categorias')
    ..set<String>('Title', 'Calças')
    ..set<int>('Position', 2);

  //salva no banco e retorna se foi sucesso ou nao
  final response = await category.save();

  if (kDebugMode) {
    print(response.success);
  }*/

  //atualizando
  /*final category = ParseObject('Categorias')..objectId = 'X00voIe3QE'..set<int>('Position', 0);

  final response = await category.save();

  if (kDebugMode) {
    print(response.success);
  }*/

  //removendo
  /*final category = ParseObject('Categorias')..objectId = 'X00voIe3QE';

  final response = await category.delete();

  if (kDebugMode) {
    print(response.success);
  }*/

  //lendo um registros (objeto, linha) da tabela Categorias
  /*final response = await ParseObject('Categorias').getObject('wvfWVAOPzC');
  if (response.success) {
    if (kDebugMode) {
      print(response.result);
    }
  }*/

  //lendo todos os registros da tabela Categorias
  /*final response = await ParseObject('Categorias').getAll();
  if (response.success) {
    for(final object in response.result){
      if (kDebugMode) {
        print(object);
      }
    }
  }*/

  //buscando os somente os registros com Position = 2
  /*final query = QueryBuilder(ParseObject('Categorias'));
  query.whereEqualTo('Position', 2);
  
  final response = await query.query();
  
  if (response.success) {
    if (kDebugMode) {
      print(response.results);
    }
  }*/

  //buscando os somente os registros que contem 'blusas' no Title
  /*final query = QueryBuilder(ParseObject('Categorias'));
  query.whereContains('Title', 'Blusas');

  final response = await query.query();

  if (response.success) {
    if (kDebugMode) {
      print(response.results);
    }
  }*/

  //juntanto duas buscas, registros que contem 'blusas' no Title e que tenham Position = 4
  /*final query = QueryBuilder(ParseObject('Categorias'));
  query.whereContains('Title', 'Blusas');
  query.whereEqualTo('Position', 4);

  final response = await query.query();

  if (response.success) {
    if (kDebugMode) {
      print(response.results);
    }
  }*/
}

Future<void> inicializeParse() async {
  await Parse().initialize(
    'PISCICULTURA',
    'http://192.168.30.132:1337/parse',
    clientKey: "12345678",
    autoSendSessionId: true, // Necessário para autenticação e ACL
    debug: true, // Quando habilitado, imprime logs no console
  );
}

/*final query = QueryBuilder(ParseObject('Categorias'));
  query.whereEqualTo('Position', 2);

  final response = await query.query();

  if (response.success) {
    if (kDebugMode) {
      print(response.results);
    }
  }*/

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO MobX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Color.fromRGBO(80, 160, 191, 1),
        ),
        scaffoldBackgroundColor: Color.fromRGBO(80, 160, 191, 1),
      ),
      home: BaseScreen(),
    );
  }
}
