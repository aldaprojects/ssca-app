import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';
import 'package:sockets2/src/validators/validators.dart' as loginValidator;
import 'package:sockets2/src/widgets/customPage_widget.dart';
import 'package:sockets2/src/widgets/pull_widget.dart';
import '../providers/usuario_provider.dart';

class PasswordPage extends StatelessWidget {
  
  final TextEditingController _emailController    = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UsuarioProvider>(context);
    final prefs = SharedPrefs();

    return CustomWidgetPage(
      tittle: '¿Olvidaste tu contraseña?',
      subtittle: 'Introduce el correo asociado con tu cuenta y te enviaremos un código de 4 dígitos que deberás introducir después.',
      image: Image.asset('assets/forgpwd.png'),
      body: Column(
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
      buttonText: 'Enviar',
      whenIsValid: () => prefs.emailPin = _emailController.text,
      pullFunction: () {
        return Pull(
          future: userProvider.reqPin(_emailController.text),
          navigator: () => Navigator.popAndPushNamed(context, 'pin'),
        );
      },
    );
  }
}
