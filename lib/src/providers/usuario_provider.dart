import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sockets2/src/models/user_model.dart';

class UsuarioProvider with ChangeNotifier{

  final String _url = 'https://api-puerta.herokuapp.com';
  User _user;

  get user => this._user;

  set user( User user ) {
    this._user = user;

    notifyListeners();
  }

  Future<Map<String, dynamic>> login( String email, String password) async {

    final authData = {
      'email'             : email,
      'password'          : password
    };

    final resp = await http.post( '$_url/login', body: authData );

    return transformUser(resp);
  }  

  Future<Map<String, dynamic>> singup( User user ) async {

    final resp = await http.post('$_url/usuario', body: user.toJson());

    return transformUser(resp);
    
  }

  Map<String, dynamic> transformUser( http.Response resp ) {
    User user = new User();

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if ( decodedResp['ok'] ) {
      user = User.fromJson(decodedResp['usuario']);
      this.user = user;
    }

    return decodedResp;
  }

}