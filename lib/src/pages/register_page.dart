import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sockets2/src/models/user_model.dart';
import 'package:sockets2/src/providers/usuario_provider.dart';
import 'package:sockets2/src/validators/validators.dart' as registerValidator;
import 'package:sockets2/src/widgets/dialog_widget.dart';
import 'package:sockets2/src/widgets/pull_widget.dart';


class SingUpPage extends StatefulWidget {
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  final formKey = GlobalKey<FormState>();

  TextEditingController _nameController      = TextEditingController();
  TextEditingController _nickController      = TextEditingController();
  TextEditingController _emailController     = TextEditingController();
  TextEditingController _passwordController  = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();

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
  }

  Widget build(BuildContext context) {

    final userProvider = Provider.of<UsuarioProvider>(context);

    return Scaffold(
      body: FadeTransition(
        opacity: animation,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _image(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: _formBody()
                ),
                SizedBox(height: 25.0),
                _footerRegister(userProvider)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _image() {
    return Column(
      children: <Widget>[
        Container(
          height: 300,
          child: FadeTransition(
            opacity: animation,
            child: FlareActor(
              'assets/SignUp.flr',
              animation: 'relax'
            )
          )
        ),
        Text(
          'No hay prisa',
          style: TextStyle(color: Colors.grey, fontSize: 17.0))
      ],
    );
  }

  Widget _formBody() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Nombre completo',
              suffixIcon: Icon(FontAwesomeIcons.user)
            ),
            validator: registerValidator.validateName
          ),
          TextFormField(
            controller: _nickController,
            decoration: InputDecoration(
              labelText: 'Apodo',
              suffixIcon: Icon(FontAwesomeIcons.userAlt)
            ),
            validator: registerValidator.validateName
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
          )
        ],
      ),
    );
  }

  Widget _footerRegister( UsuarioProvider userProvider ){
    return Column(
      children: <Widget>[
        RaisedButton(
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            width: MediaQuery.of(context).size.width * .8,
            child: Text(
              'Crear Cuenta',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          onPressed: () async {
            User user = new User(
              name: _nameController.text,
              username: _nickController.text,
              email: _emailController.text,
              password: _passwordController.text,
              fechaRegistro: DateTime.now()
            );

            bool isValid = false;
            
            if ( formKey.currentState.validate() ) isValid = true;

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
                      future: userProvider.singup(user)
                    )
                  );
                }
            );
          }
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('¿Ya tienes cuenta?'),
            FlatButton(
              child: Text('Iniciar Sesión', style: TextStyle(color: Colors.blue),),
              onPressed: () => Navigator.pushNamed(context, 'login'),
            )
          ],
        ),
      ]
    );
  }
}

