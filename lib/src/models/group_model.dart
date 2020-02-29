
import 'dart:convert';

Group userFromJson(String str) => Group.fromJson(json.decode(str));

String userToJson(Group data) => json.encode(data.toJson());

class Group {
    List<dynamic> integrantes;
    String id;
    String name;
    String codigo;
    String admin;
    DateTime fechaCreacion;

    Group({
        this.integrantes,
        this.id,
        this.name,
        this.codigo,
        this.admin,
        this.fechaCreacion
    });

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        integrantes   : List<dynamic>.from(json["integrantes"].map((x) => x)),
        id            : json["_id"],
        name          : json["name"],
        codigo        : json["codigo"],
        admin         : json["admin"],
        fechaCreacion : DateTime.parse(json["fecha_creacion"])
    );

    Map<String, dynamic> toJson() => {
        "integrantes"     : List<dynamic>.from(integrantes.map((x) => x)),
        "_id"             : id,
        "name"            : name,
        "codigo"          : codigo,
        "admin"           : admin,
        "fecha_creacion"  : fechaCreacion.toIso8601String()
    };
}
