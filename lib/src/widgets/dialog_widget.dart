import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sockets2/src/providers/usuario_provider.dart';
import 'package:sockets2/src/widgets/pull_widget.dart';

class CustomAlertDialog extends StatelessWidget {

  final String title;
  final String text;
  final Image image;
  final Color primaryColor;
  final Color secondaryColor;
  final String buttonText;
  final Function press;
  final bool anotherButton;
  final String email;

  CustomAlertDialog({
    @required this.title,
    @required this.text,
    @required this.image,
    @required this.primaryColor,
    @required this.secondaryColor,
    @required this.buttonText,
    this.press,
    this.anotherButton = false,
    this.email
  });

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UsuarioProvider>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 150,
          child: image,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0)
            )
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0),
          height: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor
                ),
              ),
              Text(text, style: TextStyle(color: Colors.black87))
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            anotherButton ? 
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: RaisedButton(
                color: primaryColor,
                elevation: 5.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                onPressed: () async {
                  Navigator.pop(context);
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        contentPadding: EdgeInsets.all(0),
                        content: Pull(
                          future: userProvider.resendEmail(email),
                          navigator: () => Navigator.pop(context),
                          okText: 'Correo enviado con exito.',
                        ),
                      );
                    }
                  );
                },
                child: Text('Reenviar correo', style: TextStyle(color: Colors.white)),
              ),
            ) : Container(),
            RaisedButton(
              color: primaryColor,
              elevation: 5.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: press != null ? press : () => Navigator.pop(context),
              child: Text(buttonText, style: TextStyle(color: Colors.white)),
            )
          ],
        )
      ],
    );
  }
}