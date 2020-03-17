import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:provider/provider.dart';
import 'package:sockets2/src/models/user_model.dart';
import 'package:sockets2/src/pages/internal_pages/anuncios_page.dart';
import 'package:sockets2/src/pages/internal_pages/home_page.dart';
import 'package:sockets2/src/pages/internal_pages/mygroup_page.dart';
import 'package:sockets2/src/pages/internal_pages/puerta_page.dart';
import 'package:sockets2/src/pages/internal_pages/registros_page.dart';
import 'package:sockets2/src/providers/usuario_provider.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';
import 'package:sockets2/src/widgets/customAppBar.dart' as widget;

import 'dart:convert';

class ControllerPage extends StatefulWidget {

  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final SharedPrefs prefs = SharedPrefs();
  User user;
  int _indexPage = 0;

  getPage( ){

    switch (_indexPage) {
      case 0:
        return HomePage();
      case 1:
        return MiGrupoPage();
      case 2:
        return RegistrosPage();
      case 3:
        return AnunciosPage();
      case 4:
        return PuertaPage();
    }
  }

  setPage(int i){
    Navigator.pop(context);
    setState(() {
      _indexPage = i;
    });
  }

  @override
  void initState(){
    super.initState();
    user = User.fromJson(json.decode(prefs.user));
    prefs.startRoute = 'home';
  }

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UsuarioProvider>(context);
    // userProvider.user = user;

    // // final JwtClaim decClaimSet = verifyJwtHS256Signature(prefs.token, 'seed');
    
    
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      if ( userProvider.user == null ) {
        userProvider.user = user;
      }

    //   // add your code here.
    //   // print(decClaimSet.expiry);
    //   // print(DateTime.now());
    
    //   // if ( decClaimSet.expiry.compareTo(DateTime.now()) < 0 ) {

    //   //   prefs.endToken = true;
    //   //   prefs.startRoute = 'login';

    //   //   Navigator.popUntil(context, ModalRoute.withName('home'));
    //   //   Navigator.pop(context);

    //   // }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: _drawer(context),
      appBar: widget.appBar( _scaffoldKey ),  
      body: ListView(
        padding: EdgeInsets.only(right: 17.0, left: 17.0, top: 10.0),
        children: <Widget>[
          getPage()
        ],
      )
    );
  }

  Widget _drawer(BuildContext context) {

    final userProvider = Provider.of<UsuarioProvider>(context);

    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              child: Center(
                child: ListTile(
                  title: Text(userProvider.user.name),
                  subtitle: Text('Ver perfil'),
                  leading: CircleAvatar(
                    maxRadius: 30,
                    child: Text(userProvider.user.name[0].toUpperCase(), style: TextStyle(fontSize: 40, color: Colors.white)),
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
                    selected: 0 == _indexPage,
                    trailing: Icon(Icons.arrow_right),
                    onTap: () => setPage(0),
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.users),
                    title: Text('Mi grupo'),
                    selected: 1 == _indexPage,
                    trailing: Icon(Icons.arrow_right),
                    onTap: () => setPage(1),
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.chartBar),
                    title: Text('Registros'),
                    selected: 2 == _indexPage,
                    trailing: Icon(Icons.arrow_right),
                    onTap: () => setPage(2),
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.bullhorn),
                    title: Text('Anuncios'),
                    selected: 3 == _indexPage,
                    trailing: Icon(Icons.arrow_right),
                    onTap: () => setPage(3),
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.doorClosed),
                    title: Text('Puerta'),
                    selected: 4 == _indexPage,
                    trailing: Icon(Icons.arrow_right),
                    onTap: () => setPage(4),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.signOutAlt),
                    title: Text('Cerrar sesión'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/');
                    },
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