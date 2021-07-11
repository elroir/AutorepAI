
import 'dart:convert';

WorkOrder workOrderModelFromJson(String str) => WorkOrder.fromJson(json.decode(str));

String workOrderModelToJson(WorkOrder data) => json.encode(data.toJson());

class WorkOrder {
    
  int codigo;
  String fechaIngreso;
  String fechaEntrega;
  bool estado;
  String foto;
  
  WorkOrder({
    this.codigo,
    this.fechaIngreso,
    this.fechaEntrega,
    this.estado,
    this.foto,
  });


  factory WorkOrder.fromJson(Map<String, dynamic> json) => WorkOrder(
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
