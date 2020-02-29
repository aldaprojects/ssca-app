import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:sockets2/src/models/user_model.dart';
import 'package:sockets2/src/providers/usuario_provider.dart';
import 'package:sockets2/src/validators/login_validator.dart' as validatorLogin;
import 'package:sockets2/src/widgets/dialog_widget.dart';


class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  final TextEditingController _emailController    = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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

    _emailController.text = 'admin@admin.com';
    _passwordController.text = 'admin';
  }

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UsuarioProvider>(context);

    return Scaffold(

      body: FadeTransition(
        opacity: animation,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _loginHeader(),
                _loginBody(),
                _loginFooter(userProvider)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginHeader() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 300,
            child: FadeTransition(
              opacity: animation,
              child: FlareActor(
                'assets/SignIn.flr',
                animation: 'login'
              )
            )
          ),
          Text(
            'Nos alegra que estés de vuelta',
            style: TextStyle(color: Colors.grey, fontSize: 14.0))
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
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Correo',
                suffixIcon: Icon(FontAwesomeIcons.at)
              ),
              validator: validatorLogin.validateEmail,
              autovalidate: true,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                suffixIcon: Icon(FontAwesomeIcons.key)
              ),
              validator: validatorLogin.validatePassword,
              autovalidate: true
            ),
            SizedBox(height: 25.0)
          ],
        ),
      ),
    );  
  }

  Widget _loginFooter( UsuarioProvider userProvider) {
    return  Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 17.0, right: 30.0),
            child: Row(
              children: <Widget>[
                Checkbox(value: false, onChanged: null),
                Text('Recuerdame'),
                Spacer(),
                Text('¿Olvidaste la contraseña?'),

              ],
            ),
          ),
          RaisedButton(
            color: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: Container(
              width: MediaQuery.of(context).size.width * .8,
              child: Text(
                'Iniciar Sesión',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: () async {

              await _login(userProvider);

            }
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('¿No tienes cuenta?'),
              FlatButton(
                child: Text('Crear una', style: TextStyle(color: Colors.blue),),
                onPressed: () => Navigator.pushNamed(context, 'register'),
              )
            ],
          ),
        ],
      ),
    );
            
  }

  Future _login( UsuarioProvider usuario ) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          contentPadding: EdgeInsets.all(0),
          content: FutureBuilder(
            future: usuario.login(_emailController.text, _passwordController.text),
            builder: ( BuildContext context, AsyncSnapshot<User> snapshot) {
              if ( snapshot.hasData ) {
                User user = snapshot.data;

                if ( user.name != null ) {
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
                  return CustomAlertDialog(
                    title: 'OH NO!',
                    text: 'Revisa tu correo o contraseña.',
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
          ),
        );
      }
    );
  }

}

