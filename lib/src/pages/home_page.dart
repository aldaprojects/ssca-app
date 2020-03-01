import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sockets2/src/providers/usuario_provider.dart';
import 'package:sockets2/src/widgets/customAppBar.dart';
import 'package:sockets2/src/widgets/sin_grupo.dart';

class HomePage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UsuarioProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: Drawer(),
      appBar: appBar( _scaffoldKey ),  
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 17.0, vertical: 20.0),
            child: Row(
              children: <Widget>[
                Text(
                  'Bienvenido, ', 
                  style: TextStyle( 
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  userProvider.user.name, 
                  style: TextStyle( 
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 80.0),
            child: SinGrupo()
          )
        ],
      )
    );
  }
}