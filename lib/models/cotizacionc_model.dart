

import 'dart:convert';

import 'package:ingemec/models/quote_detail_model.dart';
import 'package:ingemec/models/service_model.dart';
import 'package:ingemec/models/vehicle_model.dart';

CotizacionC cotizacionCFromJson(Map<String, dynamic> json) => CotizacionC.fromJson(json);
String cotizacionCToJson(CotizacionC data) => json.encode(data.toJson());

class CotizacionC {

    CotizacionC({
      this.idCotizacion,
      this.observacion,
      this.fecha,
      this.tiempoTrabajo,
      this.aprobado,
      this.estado,
      this.idUsuario,
      this.idVehiculo,
      this.vehiculo,
      this.detalles,
      this.servicios,
      this.noservicios
    });

    int idCotizacion;
    String observacion;
    DateTime fecha;
    int tiempoTrabajo;
    bool aprobado;
    bool estado;
    String idUsuario; //lol cambiar a int ash
    int idVehiculo;
    Vehicle vehiculo;
    List<QuoteDetail> detalles;
    List<Service> servicios;
    List<Service> noservicios;

    factory CotizacionC.fromJson(Map<String, dynamic> json) => CotizacionC(
        idCotizacion  : json["id_cotizacion"],
        observacion   : json["observacion"],
        fecha         : DateTime.parse(json["fecha"]),
        tiempoTrabajo : json["tiempo_trabajo"],
        aprobado      : json["aprobado"],
        estado        : json["estado"],
        idUsuario     : json["id_personal"],
        idVehiculo    : json["id_vehiculo"],
        vehiculo: Vehicle.fromJson(json["vehiculo"])
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
