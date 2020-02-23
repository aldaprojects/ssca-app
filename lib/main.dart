import 'package:flutter/material.dart';
import 'package:sockets2/src/routes/routes.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SSPA',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: getApplicationRoutes()
    );
  }
}
