import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sockets2/src/models/group_model.dart';
import 'package:sockets2/src/share_prefs/preferences.dart';

class GrupoProvider with ChangeNotifier{

  // final String _url = 'https://api-puerta.herokuapp.com';
  final String _url = 'http://192.168.1.72:3000';
  Group _group;

  final prefs = SharedPrefs();

  get group => this._group;

  set group( Group group ) {
    this._group = group;

    notifyListeners();
  }

  Future<Map<String, dynamic>> crearGrupo( Group grupo, String token ) async {
    final resp = await http.post(
      '$_url/grupo', 
      headers: {'token': token}, 
      body: { 
        'name'           : grupo.name,
        'fecha_creacion' : grupo.fechaCreacion.toString()
      }
    );

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    return decodedResp;
  }

}