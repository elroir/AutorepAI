
import 'dart:convert';

Service serviceFromJson(Map<String, dynamic> json) => Service.fromJson(json);

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
    Service({
      this.idservicio,
      this.nombre,
      this.precio,
      this.ntipo,
    });

    int idservicio;
    String nombre;
    double precio;
    String ntipo;

    factory Service.fromJson(Map<String, dynamic> json) => Service(
      idservicio : json["id_servicio"],
      nombre     : json["nombre"],
      precio     : double.parse( json["precio"] ?? 0.5),
      ntipo     : json["id_tipo"]
    );

    Map<String, dynamic> toJson() => {
      "id_servicio": idservicio.toString(),
      "nombre"     : nombre,
      "precio"     : precio.toString(),
      "ntipo"     : ntipo.toString(),
    };
}
