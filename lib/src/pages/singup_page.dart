import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SingUpPage extends StatefulWidget {
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> with TickerProviderStateMixin {

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
                            'assets/SignUp.flr',
                            animation: 'relax'
                          )
                        )
                      ),
                      Text(
                        'No hay prisa',
                        style: TextStyle(color: Colors.grey, fontSize: 17.0))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        TextField(
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                            labelText: 'Nombre completo',
                            suffixIcon: Icon(FontAwesomeIcons.user)
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Apodo',
                            suffixIcon: Icon(FontAwesomeIcons.userAlt)
                          ),
                        ),
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
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirmar contraseña',
                            suffixIcon: Icon(FontAwesomeIcons.key)
                          ),
                        ),
                        SizedBox(height: 25.0)
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .8,
                          child: Text(
                            'Crear Cuenta - Aldair',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onPressed: ()=> Navigator.pushNamed(context, 'home')
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('¿Ya tienes cuenta?'),
                          FlatButton(
                            child: Text('Iniciar Sesión', style: TextStyle(color: Colors.blue),),
                            onPressed: () => Navigator.pushNamed(context, 'login'),
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

