import 'package:flutter/material.dart';

class SinGrupo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.asset('assets/nogroup.png'),
          Center(
            child: Text(
              'No estás en un grupo aún, no estés solo...',
              style: TextStyle( fontSize: 15.0 ),
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
                onPressed: () => Navigator.pushNamed(context, 'creargrupo'),
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
        
      ),
    );
  }
}

