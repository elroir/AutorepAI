
import 'dart:convert';

Service serviceFromJson(Map<String, dynamic> json) => Service.fromJson(json);

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
    Service({
      this.idservicio,
      this.nombre,
      this.precio,
      this.estado,
      this.idTipo,
    });

    int idservicio;
    String nombre;
    double precio;
    bool estado;
    int idTipo;

    factory Service.fromJson(Map<String, dynamic> json) => Service(
      idservicio : json["id_servicio"],
      nombre     : json["nombre"],
      precio     : double.parse( json["precio"] ?? 0.5),
      estado     : json["estado"],
      idTipo     : json["id_tipo"]
    );

    Map<String, dynamic> toJson() => {
      "id_servicio": idservicio.toString(),
      "nombre"     : nombre,
      "precio"     : precio.toString(),
      "estado"     : estado.toString(),
      "id_tipo"    : idTipo.toString(),
    };
}
