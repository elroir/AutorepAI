import 'dart:convert';

class Follow {
  Follow({
    this.idOrder,
    this.description,
    this.imageUrl,
    this.date,
  });

  int idOrder;
  String description;
  String imageUrl;
  DateTime date;

  factory Follow.fromRawJson(String str) => Follow.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
    idOrder: json["id_orden"] == null ? null : json["id_orden"],
    description: json["descripcion"] == null ? null : json["descripcion"],
    imageUrl: json["url_imagen"] == null ? null : json["url_imagen"],
    date: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
  );

  Map<String, dynamic> toJson() => {
    "id_orden": idOrder == null ? null : idOrder.toString(),
    "descripcion": description == null ? null : description,
    "url_imagen": imageUrl == null ? null : imageUrl,
    "fecha": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
}
