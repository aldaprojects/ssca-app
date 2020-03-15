import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sockets2/src/providers/usuario_provider.dart';
import 'package:sockets2/src/widgets/sin_grupo.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UsuarioProvider>(context);

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'Bienvenido, ', 
              style: TextStyle( 
                fontSize: 25.0,
                fontWeight: FontWeight.bold
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Text(
                'Aldair Sanchez',
                overflow: TextOverflow.clip,
                maxLines: 1,     
                style: TextStyle( 
                  fontSize: 25.0,
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Container(
            padding: EdgeInsets.only(top: 100.0),
            child: SinGrupo()
          ),
        )
      ],
    );
  }
}