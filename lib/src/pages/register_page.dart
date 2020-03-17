import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sockets2/src/models/user_model.dart';
import 'package:sockets2/src/providers/usuario_provider.dart';
import 'package:sockets2/src/validators/validators.dart' as registerValidator;
import 'package:sockets2/src/widgets/customPage_widget.dart';
import 'package:sockets2/src/widgets/pull_widget.dart';

class SingUpPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _nameController      = TextEditingController();
  final TextEditingController _nickController      = TextEditingController();
  final TextEditingController _emailController     = TextEditingController();
  final TextEditingController _passwordController  = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  Widget build(BuildContext context) {

    final userProvider = Provider.of<UsuarioProvider>(context);
    User user;

    return CustomWidgetPage(
      disableBackButton: true,
      image: Image.asset('assets/relax.png'),
      tittle: 'Crear cuenta',
      subtittle: 'No hay prisa',
      body: Column(
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Nombre completo',
              suffixIcon: Icon(FontAwesomeIcons.user)
            ),
            validator: registerValidator.validateName,
             autovalidate: true,
          ),
          TextFormField(
            controller: _nickController,
            decoration: InputDecoration(
              labelText: 'Apodo',
              suffixIcon: Icon(FontAwesomeIcons.userAlt)
            ),
            validator: registerValidator.validateUserName,
            autovalidate: true,
          ),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Correo',
              suffixIcon: Icon(FontAwesomeIcons.at)
            ),
            validator: registerValidator.validateEmail,
            autovalidate: true,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              suffixIcon: Icon(FontAwesomeIcons.key)
            ),
            validator: registerValidator.validatePassword,
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
              return registerValidator.validateBothPassword(value, _passwordController.text);
            },
            autovalidate: true,
          ),
          SizedBox(height: 20)
        ],
      ),
      whenIsValid: () {
        user = new User(
          name: _nameController.text,
          username: _nickController.text,
          email: _emailController.text,
          password: _passwordController.text,
          fechaRegistro: DateTime.now()
        );
      },
      buttonText: 'Crear Cuenta',
      pullFunction: () {
        return Pull(
          navigator: () {
            Navigator.pop(context);
            Navigator.popAndPushNamed(context, 'login');
          },
          future: userProvider.singup(user),
          okText: 'Revisa tu correo para que puedas verificar tu cuenta.',
        );
      },
      footerWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('¿Ya tienes cuenta?'),
          FlatButton(
            child: Text('Iniciar Sesión', style: TextStyle(color: Colors.blue),),
            onPressed: () => Navigator.popAndPushNamed(context, 'login'),
          )
        ],
      )
    );
  }
}
