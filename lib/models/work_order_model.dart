import 'dart:convert';

import 'package:ingemec/models/service_model.dart';
import 'package:ingemec/models/user_model.dart';
import 'package:ingemec/models/vehicle_model.dart';

WorkOrder workOrderFromJson(String str) => WorkOrder.fromJson(json.decode(str));

String workOrderToJson(WorkOrder data) => json.encode(data.toJson());

class WorkOrder {
  WorkOrder({
    this.idOrden,
    this.idCotizacion,
    this.idPersonal,
    this.fechaIngreso,
    this.fechaEntrega,
    this.servicios,
    this.personal,
    this.detalles,
    this.detalleServicios,
    this.vehiculo
  });

  int idOrden;
  int idCotizacion;
  String idPersonal;
  DateTime fechaIngreso;
  DateTime fechaEntrega;
  Vehicle vehiculo;
  UserModel personal;
  List<Servicio> servicios;
  List<Service>  detalleServicios;
  List<OrderDetail> detalles;

  String toRawJson() => json.encode(toJson());

  factory WorkOrder.fromJson(Map<String, dynamic> json) => WorkOrder(
    idOrden: json["id_orden"] == null ? null : json["id_orden"],
    idCotizacion: json["id_cotizacion"] == null ? null : json["id_cotizacion"],
    idPersonal: json["id_personal"] == null ? null : json["id_personal"],
    fechaIngreso : DateTime.parse(json["fecha_ingreso"]),
    fechaEntrega : DateTime.parse(json["fecha_entrega"]),
    vehiculo: json["vehiculo"] == null ? null : Vehicle.fromJson(json["vehiculo"]),
    personal: json["personal"] == null ? null : UserModel.fromJson(json["personal"]),
    detalleServicios: json["servicios"] == null ? null : List<Service>.from(json["servicios"].map((x) => Service.fromJson(x))),
    detalles: json["detalles"] == null ? null : List<OrderDetail>.from(json["detalles"].map((x) => OrderDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id_orden": idOrden == null ? null : idOrden.toString(),
    "id_cotizacion": idCotizacion == null ? null : idCotizacion.toString(),
    "fecha_ingreso" : fechaIngreso == null ? null : "${fechaIngreso.year.toString().padLeft(4, '0')}-${fechaIngreso.month.toString().padLeft(2, '0')}-${fechaIngreso.day.toString().padLeft(2, '0')}",
    "fecha_entrega" : fechaEntrega == null ? null : "${fechaEntrega.year.toString().padLeft(4, '0')}-${fechaEntrega.month.toString().padLeft(2, '0')}-${fechaEntrega.day.toString().padLeft(2, '0')}",
    "id_personal": idPersonal == null ? null : idPersonal.toString(),
    "servicios": servicios == null ? null : json.encode(servicios),
  };
}

class Servicio {
  Servicio({
    this.idServicio,
    this.descripcion,
  });

  int idServicio;
  String descripcion;

  factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
    idServicio: json["id_servicio"] == null ? null : json["id_servicio"],
    descripcion: json["descripcion"] == null ? null : json["descripcion"],
  );

  Map<String, dynamic> toJson() => {
    "id_servicio": idServicio == null ? null : idServicio,
    "descripcion": descripcion == null ? null : descripcion,
  };
}

class OrderDetail {
  OrderDetail({
    this.idDetalleo,
    this.observacion,
    this.idServicio,
    this.idGradod,
    this.idOrden,
  });

  int idDetalleo;
  String observacion;
  int idServicio;
  int idGradod;
  int idOrden;

  factory OrderDetail.fromRawJson(String str) => OrderDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    idDetalleo: json["id_detalleo"] == null ? null : json["id_detalleo"],
    observacion: json["observacion"] == null ? null : json["observacion"],
    idServicio: json["id_servicio"] == null ? null : json["id_servicio"],
    idGradod: json["id_gradod"] == null ? null : json["id_gradod"],
    idOrden: json["id_orden"] == null ? null : json["id_orden"],
  );

  Map<String, dynamic> toJson() => {
    "id_detalleo": idDetalleo == null ? null : idDetalleo,
    "observacion": observacion == null ? null : observacion,
    "id_servicio": idServicio == null ? null : idServicio,
    "id_gradod": idGradod == null ? null : idGradod,
    "id_orden": idOrden == null ? null : idOrden,
  };
}