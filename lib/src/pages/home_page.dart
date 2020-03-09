import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sockets2/src/models/user_model.dart';
import 'package:sockets2/src/providers/usuario_provider.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';
import 'package:sockets2/src/widgets/customAppBar.dart';
import 'package:sockets2/src/widgets/sin_grupo.dart';

import 'package:jaguar_jwt/jaguar_jwt.dart';

import 'dart:convert';

class HomePage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final prefs = SharedPrefs();

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UsuarioProvider>(context);
    User user = User.fromJson(json.decode(prefs.user));

    final JwtClaim decClaimSet = verifyJwtHS256Signature(prefs.token, 'seed');
    
    userProvider.user = user;
    
    WidgetsBinding.instance.addPostFrameCallback((_) async {  

      // add your code here.
      print(decClaimSet.expiry);
      print(DateTime.now());
    
      if ( decClaimSet.expiry.compareTo(DateTime.now()) < 0 ) {

        print('YA EXPIRO');
        prefs.endToken = true;
        prefs.startRoute = 'login';

        Navigator.pushReplacementNamed(context, 'login');

      }
    });

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
                  user.name,
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