import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {

  final String title;
  final String text;
  final Image image;
  final Color primaryColor;
  final Color secondaryColor;
  final String buttonText;
  final Function press;

  CustomAlertDialog({
    @required this.title,
    @required this.text,
    @required this.image,
    @required this.primaryColor,
    @required this.secondaryColor,
    @required this.buttonText,
    this.press
  });

  @override
  Widget build(BuildContext context) {
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
        RaisedButton(
          color: primaryColor,
          elevation: 5.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          onPressed: press != null ? press : () => Navigator.pop(context),
          child: Text(buttonText, style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}