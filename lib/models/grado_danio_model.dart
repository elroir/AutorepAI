
import 'dart:convert';

GradoDanio gradoDanioFromJson(Map<String, dynamic> json) => GradoDanio.fromJson(json);
String gradoDanioToJson(GradoDanio data) => json.encode(data.toJson());

class GradoDanio {
    GradoDanio({
      this.idGradod,
      this.nombre,
      this.umbralMax,
      this.umbralMin,
    });

    int idGradod;
    String nombre;
    double umbralMax;
    double umbralMin;

    factory GradoDanio.fromJson(Map<String, dynamic> json) => GradoDanio(
        idGradod  : json["id_gradod"],
        nombre    : json["nombre"],
        umbralMax : json["umbral_max"].toDouble(),
        umbralMin : json["umbral_min"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id_gradod"  : idGradod,
        "nombre"     : nombre,
        "umbral_max" : umbralMax,
        "umbral_min" : umbralMin,
    };
}
