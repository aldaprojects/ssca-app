import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

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

  Widget build(BuildContext context) {

    return Scaffold(
      body: FadeTransition(
        opacity: animation,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 300,
                        child: FadeTransition(
                          opacity: animation,
                          child: FlareActor(
                            'assets/SignIn.flr',
                            animation: 'login'
                          )
                        )
                      ),
                      Text(
                        'Nos alegra que estés de vuelta',
                        style: TextStyle(color: Colors.grey, fontSize: 14.0))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Correo',
                            suffixIcon: Icon(FontAwesomeIcons.at)
                          ),
                        ),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            suffixIcon: Icon(FontAwesomeIcons.key)
                          ),
                        ),
                        SizedBox(height: 25.0)
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 17.0, right: 30.0),
                  child: Row(
                    children: <Widget>[
                      Checkbox(value: false, onChanged: null),
                      Text('Recuerdame'),
                      Spacer(),
                      Text('¿Olvidaste la contraseña?'),

                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        child: Container(
                          width: 320,
                          child: Text(
                            'Iniciar Sesión',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onPressed: ()=> Navigator.pushNamed(context, 'home')
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('¿No tienes cuenta?'),
                          FlatButton(
                            child: Text('Crear una', style: TextStyle(color: Colors.blue),),
                            onPressed: () => Navigator.pushNamed(context, 'signup'),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

