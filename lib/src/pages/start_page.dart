import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';


class StartPage extends StatefulWidget {
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;
  AnimationController controller2;
  Animation<double> animation2;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(
          milliseconds: 1500),
        vsync: this
    );
    animation = CurvedAnimation(
      parent: controller, 
      curve: Curves.easeIn
    );
    controller.forward();
    controller2 = AnimationController(
        duration: Duration(
          milliseconds: 2000),
        vsync: this
    );
    animation2 = CurvedAnimation(
      parent: controller2, 
      curve: Curves.easeIn
    );
    controller2.forward();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      body: FadeTransition(
        opacity: animation,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 300,
                child: FadeTransition(
                  opacity: animation2,
                  child: FlareActor(
                    'assets/logo.flr',
                    animation: 'loading'
                  )
                )
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Crear Cuenta',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold 
                      ),
                    ),
                    Text(
                      'No te tomará mucho tiempo',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      child: Container(
                        width: 220,
                        child: Text(
                          'Continuar con Google +',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: (){}
                    ),
                    OutlineButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      child: Container(
                        width: 220,
                        child: Text(
                          'Prefiero usar mi correo electrónico',
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () => Navigator.pushNamed(context, 'signup'), //callback when button is clicked
                      borderSide: BorderSide(
                        color: Colors.grey, //Color of the border
                        style: BorderStyle.solid, //Style of the border
                        width: 0.8, //width of the border
                      )
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('¿Ya tienes cuenta?'),
                      FlatButton(
                        child: Text('Iniciar Sesión', style: TextStyle(color: Colors.blue),),
                        onPressed: (){},
                      )
                    ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

