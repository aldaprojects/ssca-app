import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';

import 'package:pinput/pin_put/pin_put.dart';


class PinPage extends StatefulWidget {
  _PinPageState createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  final formKey = GlobalKey<FormState>();
  final prefs = SharedPrefs();

  int seconds = 300;
  String time = '5:00';

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

        if ( seconds == 0 ) {
          timer.cancel();
        }
        seconds = seconds - 1;


      });
    });

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
                    'Tiempo restante para que el pin expire: $time',
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
            PinPut(
              fieldsCount: 4,
              onSubmit: (pin) {
                print(pin);
              },
              actionButtonsEnabled: false
            ),
            SizedBox(height: 25.0),
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
            onPressed: () {
            }
          )
        ],
      ),
    );
  }
}