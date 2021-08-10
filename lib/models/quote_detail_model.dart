import 'dart:convert';

QuoteDetail quoteDetailFromJson(String str) => QuoteDetail.fromJson(json.decode(str));

String quoteDetailToJson(QuoteDetail data) => json.encode(data.toJson());

class QuoteDetail {
  QuoteDetail({
    this.idDetallec,
    this.descripcion,
    this.precioVenta,
    this.idServicio,
    this.idGradod,
    this.idCotizacion,
  });

  int idDetallec;
  String descripcion;
  String precioVenta;
  int idServicio;
  int idGradod;
  int idCotizacion;

  factory QuoteDetail.fromJson(Map<String, dynamic> json) => QuoteDetail(
    idDetallec: json["id_detallec"] == null ? null : json["id_detallec"],
    descripcion: json["descripcion"] == null ? null : json["descripcion"],
    precioVenta: json["precio_venta"] == null ? null : json["precio_venta"],
    idServicio: json["id_servicio"] == null ? null : json["id_servicio"],
    idGradod: json["id_gradod"] == null ? null : json["id_gradod"],
    idCotizacion: json["id_cotizacion"] == null ? null : json["id_cotizacion"],
  );

  Map<String, dynamic> toJson() => {
    "id_detallec": idDetallec == null ? null : idDetallec,
    "descripcion": descripcion == null ? null : descripcion,
    "precio_venta": precioVenta == null ? null : precioVenta,
    "id_servicio": idServicio == null ? null : idServicio,
    "id_gradod": idGradod == null ? null : idGradod,
    "id_cotizacion": idCotizacion == null ? null : idCotizacion,
  };
}
