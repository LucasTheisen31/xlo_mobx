import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/generated/i18n.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

Future<void> main() async {
  runApp(MyApp());

  //inicializando o ParseServer
  await Parse().initialize(
    'VTL6cIgNXcgNPSx8CSVNtTXwZGqIhOLMLQGKpjCe',
    'https://parseapi.back4app.com/',
    clientKey: '9xmzWuGZhoPt06tnuvWR3e9ZveP0q77ThwYMjt2l',
    autoSendSessionId: true,// Necessário para autenticação e ACL
    debug: true,// Quando habilitado, imprime logs no console
  );

  final category = ParseObject('categories')..set('Title', 'Camisetas')..set('Position', 2);

  final response = await category.save();

  if (kDebugMode) {
    print(response.success);
  }

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
      home: Container(),
    );
  }
}
