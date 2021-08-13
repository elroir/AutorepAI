
import 'dart:convert';

UserModel usuarioFromJson(String str) => UserModel.fromJson(json.decode(str));
UserModel usuarioFromJson1(Map<String, dynamic> json) => UserModel.fromJson(json);

String usuarioToJson(UserModel data) => json.encode(data.toJson());


class UserModel {

    UserModel({
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

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idusuario   : json["id_usuario"],
        nombre      : json["nombre"] ?? "Sin Nombre",
        email       : json["email"],
        password    : json["password"],
        telefono    : (json["telefono"]) ?? 0,
        tipoUsuario : json["tipo_usuario"],
        estado      : json["estado"]
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
