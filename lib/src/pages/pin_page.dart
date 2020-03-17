import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';

import 'package:pinput/pin_put/pin_put.dart';
import 'package:sockets2/src/widgets/customPage_widget.dart';

import '../providers/usuario_provider.dart';

class PinPage extends StatefulWidget {
  _PinPageState createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> with TickerProviderStateMixin {

  Timer _timer;

  final formKey = GlobalKey<FormState>();
  final prefs = SharedPrefs();

  int seconds = 299;
  String time = '5:00';
  int pin;

  void countdown(){
    Timer.periodic(Duration(seconds: 1), (timer) {
      print(seconds);
      _timer = timer;
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
    countdown();
  }

  @override
  void dispose(){
    super.dispose();
    _timer.cancel();
    prefs.startRoute = '/';
  }

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UsuarioProvider>(context);

    return CustomWidgetPage(
      backButtonFunction: (){
        prefs.startRoute = '/';
        Navigator.pushReplacementNamed(context, 'login');
      },
      image: Image.asset('assets/pin.png'),
      tittle: 'Introduce el código',
      subtittle: 'Si el correo está asociado, se enviará un código que expira en: ',
      aditionalText: '$time',
      aditionalTextColor: seconds == -1 ? Colors.red : Colors.blue,
      buttonText: seconds == -1 ? 'Reenviar el código' : 'Continuar',
      body: Column(
        children: <Widget>[
          PinPut(
            fieldsCount: 4,
            onSubmit: (_pin)=> pin = int.parse(_pin),
            actionButtonsEnabled: false,
            autoFocus: false,

          ),
          SizedBox(height: 25.0),
        ],
      ),
      onPressedButton: () async {
        if ( seconds >= 0 ) {
          print('Boton ${prefs.pin}');
          if ( pin == prefs.pin ) {
            prefs.startRoute = '/';
            _timer.cancel();
            Navigator.pop(context);
            Navigator.popAndPushNamed(context, 'reset');
          } else {
            print('INCORRECTO');
          }
        } else {
          await userProvider.reqPin(prefs.emailPin);
          seconds = 300;
          countdown();
        }
      }
    );
  }
}