import 'dart:convert';

Vehicle vehicleFromJson(String str) => Vehicle.fromJson(json.decode(str));

String vehicleToJson(Vehicle data) => json.encode(data.toJson());

class Vehicle {
  Vehicle({
    this.idVehiculo,
    this.nroPlaca,
    this.marca,
    this.modelo,
    this.color,
    this.urlImagen,
    this.idUsuario,
  });

  int idVehiculo;
  String nroPlaca;
  String marca;
  String modelo;
  String color;
  String urlImagen;
  String idUsuario;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    idVehiculo: json["id_vehiculo"],
    nroPlaca: json["nro_placa"],
    marca: json["marca"],
    modelo: json["modelo"],
    color: json["color"],
    urlImagen: json["url_imagen"] == null ? null : json["url_imagen"],
    idUsuario: json["id_usuario"],
  );

  Map<String, dynamic> toJson() => {
    "nro_placa": nroPlaca,
    "marca": marca,
    "modelo": modelo,
    "color": color,
    "url_imagen" : urlImagen,
    "id_usuario": idUsuario,
  };

  @override
  bool operator == (other) {
    return this.idVehiculo == other;
  }

  @override
  int get hashCode => idVehiculo.hashCode;
}
