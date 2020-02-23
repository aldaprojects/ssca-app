import 'package:flutter/material.dart';
import 'package:sockets2/src/pages/home_page.dart';
import 'package:sockets2/src/pages/start_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    '/'       : ( BuildContext context) => StartPage(),
    'home'       : ( BuildContext context) => HomePage()
  };
}