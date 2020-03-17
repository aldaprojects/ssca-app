import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sockets2/src/models/user_model.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';

class UsuarioProvider with ChangeNotifier{

  // final String _url = 'https://api-puerta.herokuapp.com';
  final String _url = 'http://192.168.1.72:3000';
  User _user;

  final prefs = SharedPrefs();

  get user => this._user;

  set user( User user ) {
    this._user = user;
    notifyListeners();
  }

  Map<String, dynamic> getDecodedResp( http.Response resp  ) {

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    decodedResp['statusCode'] = resp.statusCode;

    return decodedResp;

  }

  Map<String, dynamic> transformUser( http.Response resp ) {
    User user = new User();

    final decodedResp = getDecodedResp(resp);

    if ( decodedResp['ok'] ) {
      user = User.fromJson(decodedResp['usuario']);
      this.user = user;
      prefs.token = decodedResp['token'];
      prefs.user = userToJson(user);
    }

    return decodedResp;
  }

  Future<Map<String, dynamic>> login( String email, String password) async {

    final authData = {
      'email'             : email,
      'password'          : password
    };

    try {
      final resp = await http.post( '$_url/login', body: authData );
      return transformUser(resp);
    } on Exception catch(e) {
      return { 'ok': false, 'statusCode': 500 };
    }

  }  

  Future<Map<String, dynamic>> singup( User user ) async {

    final authData = {
      'email' : user.email,
      'password' : user.password,
      'name' : user.name,
      'username' : user.username,
      'fecha_registro' : user.fechaRegistro.toString()
    };

    try {
      final resp = await http.post('$_url/usuario', body: authData);
      return transformUser(resp);
    }on Exception catch(e) {
      return { 'ok': false, 'statusCode': 500 };
    }

  }

  Future<Map<String, dynamic>> reqPin( String email ) async {

    try{
      final resp = await http.post('$_url/usuario/pin', body: {'email': email});

      final decodedResp = getDecodedResp(resp);

      if ( decodedResp['ok'] ) {
        prefs.pin = decodedResp['pin'];
      }

      return decodedResp;
    }on Exception catch(e) {
      return { 'ok': false, 'statusCode': 500 };
    }

  }

  Future<Map<String, dynamic>> resendEmail( String email ) async {
    try{
      final resp = await http.get('$_url/usuario/u/resend', headers: {'email': email});
      return getDecodedResp(resp);
    }on Exception catch(e) {
      return { 'ok': false, 'statusCode': 500 };
    }
  }

  Future<Map<String, dynamic>> updatePassword( String email, String password ) async {
    try{
      final resp = await http.put('$_url/usuario/password?email=$email', body: {'password': password });
      return getDecodedResp(resp);
    }on Exception catch(e) {
      return { 'ok': false, 'statusCode': 500 };
    }
  }

}