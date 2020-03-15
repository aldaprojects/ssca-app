import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:sockets2/src/providers/usuario_provider.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';
import 'package:sockets2/src/validators/validators.dart' as loginValidator;
import 'package:sockets2/src/widgets/dialog_widget.dart';
import 'package:sockets2/src/widgets/pull_widget.dart';


class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  final TextEditingController _emailController    = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final prefs = SharedPrefs();


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
                secondaryColor: Color(0xffF3BCBE),
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
            SizedBox(height: 25.0)
          ],
        ),
      ),
    );  
  }

  Widget _loginFooter( UsuarioProvider userProvider ) {
    return  Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Checkbox(
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
                  child: Text('¿Olvidaste la contraseña?', style: TextStyle(color: Colors.blue)),
                  onPressed: () => Navigator.pushNamed(context, 'pwd'),
                ),
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

              if ( prefs.remember ) {
                prefs.email = _emailController.text;
              } else {
                prefs.email = '';
              }

              bool isValid = false;
            
              if ( formKey.currentState.validate() ) {
                isValid = true;
                prefs.startRoute = 'home';
              }

              await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    contentPadding: EdgeInsets.all(0),
                    content: !isValid
                    ? 
                    CustomAlertDialog(
                      title: 'OH NO!',
                      text: 'Hubo un error, revisa bien los campos.',
                      image: Image.asset('assets/ohno.png'),
                      primaryColor: Color(0xffE05A61),
                      secondaryColor: Color(0xffF3BCBE),
                      buttonText: 'OK',
                    )
                    :
                    Pull(
                      navigator: () => Navigator.pushNamedAndRemoveUntil(context, 'home', (Route<dynamic> route) => false),
                      future: userProvider.login(_emailController.text, _passwordController.text),
                      email: _emailController.text,
                    )
                  );
                }
              );

            }
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('¿No tienes cuenta?'),
              FlatButton(
                child: Text('Crear una', style: TextStyle(color: Colors.blue),),
                onPressed: () => Navigator.popAndPushNamed(context, 'register'),
              )
            ],
          ),
        ],
      ),
    );
            
  }

}