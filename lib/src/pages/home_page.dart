import 'package:flutter/material.dart';
import 'package:sockets2/src/widgets/bienvenido.dart';
import 'package:sockets2/src/widgets/customAppBar.dart';
import 'package:sockets2/src/widgets/sin_grupo.dart';

class HomePage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: Drawer(),
      appBar: appBar( _scaffoldKey ),  
      body: Column(
        children: <Widget>[
          Bievenido(nombre: 'Aldair'),
          Container(
            padding: EdgeInsets.only(top: 80.0),
            child: SinGrupo()
          )
        ],
      )
    );
  }
}