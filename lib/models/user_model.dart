
import 'dart:convert';

User usuarioFromJson(String str) => User.fromJson(json.decode(str));
User usuarioFromJson1(Map<String, dynamic> json) => User.fromJson(json);

String usuarioToJson(User data) => json.encode(data.toJson());


class User {

    User({
      this.idusuario,
      this.nombre,
      this.email,
      this.password,
      this.telefono,
      this.tipoUsuario,
      this.estado,
    });

    String idusuario;
    String nombre;
    String email;
    String password;
    int telefono;
    String tipoUsuario;
    bool estado;

    factory User.fromJson(Map<String, dynamic> json) => User(
        idusuario   : json["id_usuario"],
        nombre      : json["nombre"] ?? " ",
        email       : json["email"],
        password    : json["password"],
        telefono    : int.parse(json["telefono"] ?? "0"),
        tipoUsuario : json["tipo_usuario"],
        estado      : json["estado"]
        // estado      : (json["estado"] != null) ? ((json["estado"] == "true") ? true : false) : true
    );

    Map<String, dynamic> toJson() => {
        "id_usuario"   : idusuario,
        "nombre"       : nombre,
        "email"        : email,
        "password"     : password,
        "telefono"     : telefono.toString(),
        "tipo_usuario" : tipoUsuario,
        "estado"       : estado.toString(),
    };
}
