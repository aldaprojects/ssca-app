import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';
import 'package:sockets2/src/validators/validators.dart' as resetValidator;

import '../providers/usuario_provider.dart';
import '../widgets/dialog_widget.dart';
import '../widgets/pull_widget.dart';


class ResetPwdPage extends StatefulWidget {
  _ResetPwdPageState createState() => _ResetPwdPageState();
}

class _ResetPwdPageState extends State<ResetPwdPage> with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;


  TextEditingController _passwordController  = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final prefs = SharedPrefs();

  initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(
          milliseconds: 500),
        vsync: this
    );
    animation = CurvedAnimation(
      parent: controller, 
      curve: Curves.easeIn
    );
    controller.forward();

  }

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UsuarioProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: animation,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _loginHeader(),
              _loginBody(),
              _loginFooter(userProvider)
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginHeader() {
    return Container(
      padding: EdgeInsets.only(top: 70.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 250,
            child: FadeTransition(
              opacity: animation,
              child: Image.asset('assets/resetpwd.png')
            )
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Ingresa tu contraseña nueva',
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(height: 10.0),
                Text(
                    'Esta vez no la olvides.',
                    style: TextStyle(fontSize: 15.0, color: Colors.black54),
                    textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _loginBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
              TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                suffixIcon: Icon(FontAwesomeIcons.key)
              ),
              validator: resetValidator.validatePassword,
              autovalidate: true,
            ),
            TextFormField(
              controller: _passwordController2,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirmar contraseña',
                suffixIcon: Icon(FontAwesomeIcons.key)
              ),
              validator: (value) {
                return resetValidator.validateBothPassword(value, _passwordController.text);
              },
              autovalidate: true,
            ),
            SizedBox(height: 25.0)
          ],
        ),
      ),
    );
  }

  Widget _loginFooter( UsuarioProvider userProvider ) {
    return  Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            color: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: Container(
              width: MediaQuery.of(context).size.width * .8,
              child: Text(
                'Cambiar contraseña',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: () async {

              bool isValid = false;
            
              if ( formKey.currentState.validate() ) isValid = true;

              await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    contentPadding: EdgeInsets.all(0),
                    content: !isValid
                    ? 
                    CustomAlertDialog(
                      title: 'OH NO!',
                      text: 'Revisa bien los campos.',
                      image: Image.asset('assets/ohno.png'),
                      primaryColor: Color(0xffE05A61),
                      secondaryColor: Color(0xffF3BCBE),
                      buttonText: 'OK',
                    )
                    :
                    Pull(
                      navigator: () => Navigator.pushReplacementNamed(context, 'login'),
                      future: userProvider.updatePassword(prefs.emailPin, _passwordController.text)
                    )
                  );
                }
              );
            }
          )
        ],
      ),
    );
  }
}