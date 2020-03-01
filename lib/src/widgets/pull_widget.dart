import 'package:flutter/material.dart';

import 'package:sockets2/src/widgets/dialog_widget.dart';

class Pull extends StatelessWidget {


  final Future<Map<String, dynamic>> future;

  Pull({@required this.future});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: future,
      builder: ( BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if ( snapshot.hasData ) {
          Map<String, dynamic> data = snapshot.data;

          if ( data['ok'] ) {
            return CustomAlertDialog(
              title: 'GENIAL!',
              text: 'Todo está correcto, puedes continuar.',
              image: Image.asset('assets/success.png'),
              primaryColor: Color(0xff399F7F),
              secondaryColor: Color(0xffB1E6D5),
              buttonText: 'CONTINUAR',
              press: () => Navigator.pushNamedAndRemoveUntil(context, 'home', (Route<dynamic> route) => false)
            );
          } else {
            dynamic message = data['err']['errors'];
            if ( !message.containsKey('message') ) {
              message = 'Hubo un error, revisa bien los campos.';
            } else {
              message = data['err']['errors']['message'];
            }
            return CustomAlertDialog(
              title: 'OH NO!',
              text: message,
              image: Image.asset('assets/ohno.png'),
              primaryColor: Color(0xffE05A61),
              secondaryColor: Color(0xffF3BCBE),
              buttonText: 'OK',
            );
          }
        } else {
          return CustomAlertDialog(
            title: 'CARGANDO!',
            text: 'Estamos revisando que todo esté bien.',
            image: Image.asset('assets/loading.png'),
            primaryColor: Color(0xff70AAFB),
            secondaryColor: Color(0xffCAE2FF),
            buttonText: 'CANCELAR',
          );
        }
      },
    );
  }
}