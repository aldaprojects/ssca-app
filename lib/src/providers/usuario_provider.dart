import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sockets2/src/models/user_model.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';

class UsuarioProvider with ChangeNotifier{

  final String _url = 'http://192.168.0.110:3000';
  User _user;

  final prefs = SharedPrefs();

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

    final authData = {
      'email' : user.email,
      'password' : user.password,
      'name' : user.name,
      'username' : user.username,
      'fecha_registro' : user.fechaRegistro.toString()
    };

    final resp = await http.post('$_url/usuario', body: authData);

    return transformUser(resp);
  }

  Map<String, dynamic> transformUser( http.Response resp ) {
    User user = new User();

    print(resp.body);

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if ( decodedResp['ok'] ) {
      user = User.fromJson(decodedResp['usuario']);
      this.user = user;
        prefs.token = decodedResp['token'];
      prefs.user = userToJson(user);

    }

    return decodedResp;
  }

}