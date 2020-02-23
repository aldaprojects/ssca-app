import 'package:flutter/material.dart';

class SinGrupo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset('assets/turist.png'),
        Center(
          child: Text(
            '¿Recién llegaste y no sabes a dónde ir?',
            style: TextStyle( fontSize: 17.0 ),
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text(
                'Crear grupo',
                style: TextStyle(
                  color: Colors.blue
                ),
              ),
              onPressed: () {},
            ),
            FlatButton(
              child: Text(
                'Unirse a uno',
                style: TextStyle(
                  color: Colors.blue
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ],
      
    );
  }
}

