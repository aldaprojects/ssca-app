import 'package:flutter/material.dart';

class Bievenido extends StatelessWidget {

  final nombre;

  Bievenido({this.nombre});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17.0, vertical: 20.0),
      child: Row(
        children: <Widget>[
          Text(
            'Bienvenido, ', 
            style: TextStyle( 
              fontSize: 25.0,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            nombre, 
            style: TextStyle( 
              fontSize: 25.0,
            ),
          ),
        ],
      ),
    );
  }
}
