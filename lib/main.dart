import 'package:flutter/material.dart';
import 'package:sockets2/src/providers/usuario_provider.dart';
import 'package:sockets2/src/routes/routes.dart';

import 'package:provider/provider.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: ( context ) => UsuarioProvider() )
      ],
      child: MaterialApp(
        title: 'SSPA',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: getApplicationRoutes()
      ),
    );
  }
}
