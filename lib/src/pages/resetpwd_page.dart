import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';
import 'package:sockets2/src/validators/validators.dart' as resetValidator;
import 'package:sockets2/src/widgets/customPage_widget.dart';

import '../providers/usuario_provider.dart';
import '../widgets/pull_widget.dart';

class ResetPwdPage extends StatelessWidget {

  final TextEditingController _passwordController  = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final prefs = SharedPrefs();
  
  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UsuarioProvider>(context);

    return CustomWidgetPage(
      image: Image.asset('assets/resetpwd.png'),
      tittle: 'Ingresa tu contraseña nueva',
      subtittle: 'Esta vez no la olvides.',
      buttonText: 'Cambiar contraseña',
      body: Column(
        children: <Widget>[
            TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              suffixIcon: Icon(FontAwesomeIcons.key)
            ),
            validator: resetValidator.validatePassword,
            autovalidate: true,
          ),
          TextFormField(
            controller: _passwordController2,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirmar contraseña',
              suffixIcon: Icon(FontAwesomeIcons.key)
            ),
            validator: (value) {
              return resetValidator.validateBothPassword(value, _passwordController.text);
            },
            autovalidate: true,
          ),
          SizedBox(height: 25.0)
        ],
      ),
      pullFunction: () {
        return Pull(
          navigator: () => Navigator.pushReplacementNamed(context, 'login'),
          future: userProvider.updatePassword(prefs.emailPin, _passwordController.text)
        );
      }
    );
  }
}
