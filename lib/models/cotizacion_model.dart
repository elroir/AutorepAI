// To parse this JSON data, do
//
//     final cotizacionModel = cotizacionModelFromJson(jsonString);

import 'dart:convert';

Cotizacion cotizacionFromJson(Map<String, dynamic> json) => Cotizacion.fromJson(json);
String cotizacionToJson(Cotizacion data) => json.encode(data.toJson());

class Cotizacion {

    Cotizacion({
      this.idCotizacion,
      this.observacion,
      this.fecha,
      this.tiempoTrabajo,
      this.aprobado,
      this.estado,
      this.idUsuario,
      this.idVehiculo,
    });

    int idCotizacion;
    String observacion;
    DateTime fecha;
    int tiempoTrabajo;
    bool aprobado;
    bool estado;
    String idUsuario; //lol cambiar a int ash
    int idVehiculo;

    factory Cotizacion.fromJson(Map<String, dynamic> json) => Cotizacion(
        idCotizacion  : json["id_cotizacion"],
        observacion   : json["observacion"],
        fecha         : DateTime.parse(json["fecha"]),
        tiempoTrabajo : json["tiempo_trabajo"],
        aprobado      : json["aprobado"],
        estado        : json["estado"],
        idUsuario     : json["id_personal"],
        idVehiculo    : json["id_vehiculo"],
    );

    Map<String, dynamic> toJson() => {
        "id_cotizacion"  : idCotizacion,
        "observacion"    : observacion,
        "fecha"          : "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "tiempo_trabajo" : tiempoTrabajo,
        "aprobado"       : aprobado,
        "estado"         : estado,
        "id_usuario"     : idUsuario,
        "id_vehiculo"    : idVehiculo,
    };
}
