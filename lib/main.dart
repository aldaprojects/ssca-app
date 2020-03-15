import 'package:flutter/material.dart';
import 'package:sockets2/src/providers/usuario_provider.dart';
import 'package:sockets2/src/routes/routes.dart';

import 'package:provider/provider.dart';

import 'src/share_prefs/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = SharedPrefs();
  await prefs.initPrefs();

  print(prefs.user);
  print(prefs.token);
  print(prefs.startRoute);
  print(prefs.endToken);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider( create: ( context ) => UsuarioProvider() )
    ],
    child: MyApp(),
  ));
}
 
class MyApp extends StatelessWidget {

  final prefs = SharedPrefs();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SSPA',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: getApplicationRoutes()
    );
  }
}
