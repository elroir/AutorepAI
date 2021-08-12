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

  String toRawJson() => json.encode(toJson());

  factory WorkOrder.fromJson(Map<String, dynamic> json) => WorkOrder(
    idOrden: json["id_orden"] == null ? null : json["id_orden"],
    idCotizacion: json["id_cotizacion"] == null ? null : json["id_cotizacion"],
    idPersonal: json["id_personal"] == null ? null : json["id_personal"],
    fechaIngreso : DateTime.parse(json["fecha_ingreso"]),
    fechaEntrega : DateTime.parse(json["fecha_entrega"]),
    servicios: json["servicios"] == null ? null : List<Servicio>.from(json["servicios"].map((x) => Servicio.fromJson(x))),
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
