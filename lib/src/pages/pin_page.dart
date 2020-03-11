import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:provider/provider.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';

import 'package:pinput/pin_put/pin_put.dart';

import '../providers/usuario_provider.dart';

class PinPage extends StatefulWidget {

  final String texto;
  final Future navigator;

  PinPage({this.texto, this.navigator});
  _PinPageState createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  final formKey = GlobalKey<FormState>();
  final prefs = SharedPrefs();

  int seconds = 299;
  String time = '5:00';
  int pin;

  void countdown(){
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        int minutos = (seconds/60).floor();
        int segundos = seconds%60;
        time = '$minutos:';
        if ( segundos < 10 ) {
          time += '0$segundos';
        } else {
          time += '$segundos';
        }

        if ( seconds <= 0 ) {
          timer.cancel();
          time = '0:00';
          seconds = 0;
        }
        seconds = seconds - 1;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if ( prefs.startRoute != "pin" ) {
      prefs.date = DateTime.now().toString();
      prefs.startRoute = 'pin';
    } else {
      seconds = seconds - DateTime.now().difference(DateTime.parse(prefs.date)).inSeconds;
    }

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

    countdown();
    
  }

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UsuarioProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: (){
            prefs.startRoute = '/';
            Navigator.pushNamed(context, 'login');
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: animation,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
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
    return Column(
      children: <Widget>[
        Container(
          height: 250,
          child: FadeTransition(
            opacity: animation,
            child: Image.asset('assets/pin.png')
          )
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Text(
                'Introduce el pin',
                style: TextStyle(fontSize: 25.0),
              ),
              SizedBox(height: 20.0),
              Text(
                  'Si el correo está asociado, se enviará un pin que expira en: ',
                  style: TextStyle(fontSize: 15.0, color: Colors.black54),
                  textAlign: TextAlign.center,
              ),
              Text('$time', 
                style: TextStyle(
                  color: seconds == -1 ? Colors.red : Colors.blue,
                  fontSize: 20.0
                )
              )
            ],
          ),
        )
      ]
    );
  }

  Widget _loginBody() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          PinPut(
            fieldsCount: 4,
            onSubmit: (_pin)=> pin = int.parse(_pin),
            actionButtonsEnabled: false,
            autoFocus: false,

          ),
          SizedBox(height: 25.0),
        ],
      )
    );
  }

  Widget _loginFooter(UsuarioProvider userProvider) {
    return  Column(
      children: <Widget>[
        RaisedButton(
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            width: MediaQuery.of(context).size.width * .8,
            child: Text(
              seconds == -1 ? 'Reenviar el código' : 'Continuar',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          onPressed: () async {
            if ( seconds >= 0 ) {
              print('Boton ${prefs.pin}');
              if ( pin == prefs.pin ) {
                prefs.startRoute = '/';
                Navigator.pushReplacementNamed(context, 'reset');
              } else {
                print('INCORRECTO');
              }
            } else {
              await userProvider.reqPin(prefs.emailPin);
              seconds = 300;
              countdown();
            }
          }
        )
      ]
    );
  }
}