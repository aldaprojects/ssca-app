import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sockets2/src/models/user_model.dart';
import 'package:sockets2/src/providers/usuario_provider.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';
import 'package:sockets2/src/widgets/customAppBar.dart' as widget;
import 'package:sockets2/src/widgets/sin_grupo.dart';

import 'dart:convert';

class HomePage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final SharedPrefs prefs = SharedPrefs();

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UsuarioProvider>(context);
    User user = User.fromJson(json.decode(prefs.user));

    // final JwtClaim decClaimSet = verifyJwtHS256Signature(prefs.token, 'seed');
    
    // userProvider.user = user;
    
    // WidgetsBinding.instance.addPostFrameCallback((_) async {  

    //   // add your code here.
    //   print(decClaimSet.expiry);
    //   print(DateTime.now());
    
    //   if ( decClaimSet.expiry.compareTo(DateTime.now()) < 0 ) {

    //     prefs.endToken = true;
    //     prefs.startRoute = 'login';

    //     Navigator.pushReplacementNamed(context, 'login');

    //   }
    // });

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: _drawer(context),
      appBar: widget.appBar( _scaffoldKey ),  
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  Text(
                    'Bienvenido, ', 
                    style: TextStyle( 
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: Text(
                      user.name,
                      overflow: TextOverflow.clip,
                      maxLines: 1,     
                      style: TextStyle( 
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: SinGrupo()
            )
          ],
        ),
      )
    );
  }

  Widget _drawer(BuildContext context){

    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              child: Center(
                child: ListTile(
                  title: Text('Mario Aldair Sanchez Ramirez'),
                  subtitle: Text('Ver perfil'),
                  leading: CircleAvatar(
                    maxRadius: 30,
                    child: Text('M', style: TextStyle(fontSize: 40, color: Colors.white)),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
            ),
            Divider(thickness: 2.0),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(FontAwesomeIcons.home),
                    title: Text('Inicio'),
                    trailing: Icon(Icons.arrow_right),
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.users),
                    title: Text('Mi grupo'),
                    trailing: Icon(Icons.arrow_right),
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.chartBar),
                    title: Text('Reportes'),
                    trailing: Icon(Icons.arrow_right),
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.doorClosed),
                    title: Text('Puerta'),
                    trailing: Icon(Icons.arrow_right),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.signOutAlt),
                    title: Text('Cerrar sesión'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}