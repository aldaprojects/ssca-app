// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:sockets2/src/models/group_model.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    bool llave;
    String role;
    Group grupo;
    bool google;
    String id;
    String name;
    String email;
    String username;
    DateTime fechaRegistro;
    String password;

    User({
        this.llave,
        this.role,
        this.grupo,
        this.google,
        this.id,
        this.name,
        this.email,
        this.username,
        this.fechaRegistro,
        this.password
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        llave         : json["llave"],
        role          : json["role"],
        grupo         : json["grupo"] == null ? null : Group.fromJson(json["grupo"]),
        google        : json["google"],
        id            : json["_id"],
        name          : json["name"],
        email         : json["email"],
        username      : json["username"],
        fechaRegistro : DateTime.parse(json["fecha_registro"]),
    );

    Map<String, dynamic> toJson() => {
        "llave"           : llave,
        "role"            : role,
        "grupo"           : grupo == null ? null : grupo.toJson(),
        "google"          : google,
        "_id"             : id,
        "name"            : name,
        "email"           : email,
        "username"        : username,
        "fecha_registro"  : fechaRegistro.toIso8601String(),
        "password"        : password
    };
}