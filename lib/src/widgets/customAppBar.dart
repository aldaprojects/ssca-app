import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 

PreferredSizeWidget appBar( _scaffoldKey ){
  return AppBar(
    leading: IconButton( 
      icon: Icon( FontAwesomeIcons.bars, color: Colors.black, ), 
      onPressed: () => _scaffoldKey.currentState.openDrawer()
    ),
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    actions: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Stack(
          children: <Widget>[
            IconButton( 
              icon: Icon( FontAwesomeIcons.solidBell, color: Colors.black, ), 
              onPressed: (){}
            ),
            Container(
              child: Center( child: Text('1', style: TextStyle( color: Colors.white, fontSize: 13.0 ),) ),
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20.0)
              ),
            )
          ],
        ),
      )
      
    ],
  );
}
