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

  Future<User> login( String email, String password) async {

    User user = new User();

    final authData = {
      'email'             : email,
      'password'          : password
    };

    final resp = await http.post(
      '$_url/login',
      body: authData
    );

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if ( decodedResp['ok'] ) {
      user = User.fromJson(decodedResp['usuario']);
      this.user = user;
    }

    return user;
  }  

}