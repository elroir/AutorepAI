import 'dart:convert';

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
  });

  int idOrden;
  int idCotizacion;
  String idPersonal;
  DateTime fechaIngreso;
  DateTime fechaEntrega;
  List<Servicio> servicios;

  factory WorkOrder.fromJson(Map<String, dynamic> json) => WorkOrder(
    idOrden: json["id_orden"] == null ? null : json["id_orden"],
    idCotizacion: json["id_cotizacion"] == null ? null : json["id_cotizacion"],
    idPersonal: json["id_personal"] == null ? null : json["id_personal"],
    fechaIngreso : DateTime.parse(json["fecha_ingreso"]),
    fechaEntrega : DateTime.parse(json["fecha_entrega"]),
    servicios: json["servicios"] == null ? null : List<Servicio>.from(json["servicios"].map((x) => Servicio.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id_orden": idOrden == null ? null : idOrden,
    "id_cotizacion": idCotizacion == null ? null : idCotizacion,
    "id_personal": idPersonal == null ? null : idPersonal,

    "servicios": servicios == null ? null : List<dynamic>.from(servicios.map((x) => x.toJson())),
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
