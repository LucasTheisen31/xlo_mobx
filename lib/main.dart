import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/generated/i18n.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/screens/base/base_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //inicializando o ParseServer
  await inicializeParse();
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
    'VTL6cIgNXcgNPSx8CSVNtTXwZGqIhOLMLQGKpjCe',
    'https://parseapi.back4app.com/',
    clientKey: '9xmzWuGZhoPt06tnuvWR3e9ZveP0q77ThwYMjt2l',
    autoSendSessionId: true, // Necessário para autenticação e ACL
    debug: true, // Quando habilitado, imprime logs no console
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO MobX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BaseScreen(),
    );
  }
}
