import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:sockets2/src/providers/usuario_provider.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';
import 'package:sockets2/src/validators/validators.dart' as loginValidator;
import 'package:sockets2/src/widgets/customPage_widget.dart';
import 'package:sockets2/src/widgets/dialog_widget.dart';
import 'package:sockets2/src/widgets/pull_widget.dart';


class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {

  final TextEditingController _emailController    = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final prefs = SharedPrefs();

  initState() {
    super.initState();
    _emailController.text = prefs.email;
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) async {

      if ( prefs.endToken ) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              contentPadding: EdgeInsets.all(0),
              content: CustomAlertDialog(
                title: 'SESIÓN CADUCADA!',
                text: 'Vuelve a iniciar sesión para continuar.',
                image: Image.asset('assets/ohno.png'),
                primaryColor: Color(0xffE05A61),
                buttonText: 'OK',
              )
            );
          }
        );
        prefs.startRoute = '/';
        prefs.endToken = false;
      }
      
    });

    final userProvider = Provider.of<UsuarioProvider>(context);

    return CustomWidgetPage(
      disableBackButton: true,
      image: Image.asset('assets/signin.png'),
      tittle: 'Bienvenido',
      subtittle: 'Nos alegra que estés de vuelta',
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
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              suffixIcon: Icon(FontAwesomeIcons.key)
            ),
            validator: loginValidator.validatePassword,
            autovalidate: true
          ),
          SizedBox(height: 25.0),
          Row(
            children: <Widget>[
              Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: prefs.remember, 
                onChanged: (value) {
                  setState(() {
                    prefs.remember = value;
                  });
                }
              ),
              Text('Recuerdame'),
              Spacer(),
              FlatButton(
                padding: EdgeInsets.all(0),
                child: Text('¿Olvidaste la contraseña?', style: TextStyle(color: Colors.blue)),
                onPressed: () => Navigator.pushNamed(context, 'pwd'),
              ),
            ],
          )
        ],
      ),
      buttonText: 'Iniciar Sesión',
      whenIsValid: (){
        if ( prefs.remember ) {
          prefs.email = _emailController.text;
        } else {
          prefs.email = '';
        }
      },
      pullFunction: (){
        return Pull(
          navigator: () => Navigator.pushNamedAndRemoveUntil(context, 'home', (Route<dynamic> route) => false),
          future: userProvider.login(_emailController.text, _passwordController.text),
          email: _emailController.text,
        );
      },
      footerWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('¿No tienes cuenta?'),
          FlatButton(
            child: Text('Crear una', style: TextStyle(color: Colors.blue),),
            onPressed: () => Navigator.popAndPushNamed(context, 'register'),
          )
        ],
      )
    );
  }
}