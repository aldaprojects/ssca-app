import 'package:flutter/material.dart';

import 'package:sockets2/src/widgets/dialog_widget.dart';

class Pull extends StatelessWidget {

  final Future<Map<String, dynamic>> future;
  final Function navigator;
  final String okText;
  final String email;

  Pull({
    @required this.future, 
    @required this.navigator, 
    this.okText = 'Todo está correcto, puedes continuar.',
    this.email
  });

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
              text: okText,
              image: Image.asset('assets/success.png'),
              primaryColor: Color(0xff399F7F),
              buttonText: 'CONTINUAR',
              press: navigator
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
              buttonText: 'OK',
              anotherButton: data['err']['errors'].containsKey('noVerificada') ? true : false,
              email: email,
            );
          }
        } else {
          return CustomAlertDialog(
            title: 'CARGANDO!',
            text: 'Estamos revisando que todo esté bien.',
            image: Image.asset('assets/loading.png'),
            primaryColor: Color(0xff70AAFB),
            buttonText: 'CANCELAR',
          );
        }
      },
    );
  }
}