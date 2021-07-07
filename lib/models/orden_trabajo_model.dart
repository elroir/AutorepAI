
import 'dart:convert';

OrdenTrabajoModel ordenTrabajoModelFromJson(String str) => OrdenTrabajoModel.fromJson(json.decode(str));

String ordenTrabajoModelToJson(OrdenTrabajoModel data) => json.encode(data.toJson());

class OrdenTrabajoModel {
    
  int codigo;
  String fechaIngreso;
  String fechaEntrega;
  bool estado;
  String foto;
  
  OrdenTrabajoModel({
    this.codigo,
    this.fechaIngreso,
    this.fechaEntrega,
    this.estado,
    this.foto,
  });


  factory OrdenTrabajoModel.fromJson(Map<String, dynamic> json) => OrdenTrabajoModel(
    codigo       : json["codigo"],
    fechaIngreso : json["fecha_ingreso"],
    fechaEntrega : json["fecha_entrega"],
    estado       : json["estado"],
    foto         : json["foto"]
  );

  Map<String, dynamic> toJson() => {
    "codigo"        : codigo,
    "fecha_ingreso" : fechaIngreso,
    "fecha_entrega" : fechaEntrega,
    "estado"        : estado,
    "foto"          : foto
  };
}
