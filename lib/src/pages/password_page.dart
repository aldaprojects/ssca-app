import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';
import 'package:sockets2/src/validators/validators.dart' as loginValidator;


class PasswordPage extends StatefulWidget {
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  final TextEditingController _emailController    = TextEditingController();

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: animation,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _loginHeader(),
              _loginBody(),
              _loginFooter()
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
              child: Image.asset('assets/forgpwd.png')
            )
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(height: 20.0),
                Text(
                    'Introduce tu correo asociado con tu cuenta y te enviaremos un código de 4 dígitos que deberás introducir después.',
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
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Correo',
                suffixIcon: Icon(FontAwesomeIcons.at)
              ),
              validator: loginValidator.validateEmail,
              autovalidate: true,
            ),
            SizedBox(height: 25.0)
          ],
        ),
      ),
    );
  }

  Widget _loginFooter() {
    return  Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            color: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: Container(
              width: MediaQuery.of(context).size.width * .8,
              child: Text(
                'Enviar',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, 'pin')
          )
        ],
      ),
    );
  }
}