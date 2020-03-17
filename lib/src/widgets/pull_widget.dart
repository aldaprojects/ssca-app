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
      future: future.timeout(Duration(seconds: 20),
      onTimeout: () {
        return {'ok' : false, 'statusCode' : 408};
      }),
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

            if ( data['statusCode'] == 500 ) {
              return CustomAlertDialog(
                title: 'Oops!',
                text: 'Algo anda mal con el servidor, lo sentimos.',
                image: Image.asset('assets/badserver.png'),
                primaryColor: Colors.grey,
                buttonText: 'OK',
              );
            }

            if ( data['statusCode'] == 408 ) {
              return CustomAlertDialog(
                title: 'Tiempo de espera excedido',
                text: 'Algo anda mal con tu conexión a internet. Si el problema persiste puede ser un error del servidor.',
                image: Image.asset('assets/network.png'),
                primaryColor: Colors.grey,
                buttonText: 'OK',
              );
            }
            dynamic message = data['err']['errors'];

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
            title: 'CARGANDO...',
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