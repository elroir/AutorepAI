


import 'dart:convert';

import 'package:get/get.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/services/cotizacion_service.dart';

    // ignore: unnecessary_statements
class CotizacionController extends GetxController{

  CotizacionService instance = CotizacionService.instance;

  List<Cotizacion> _cotizaciones = [];
  Cotizacion _cotizacion;

  List<Cotizacion> get cotizaciones => _cotizaciones;
  Cotizacion get cotizacion => _cotizacion;

  @override
  void onInit() {
    super.onInit();
    getCotizaciones();
  }

  void getCotizaciones() async {
    _cotizaciones = await  instance.getCotizaciones();
    update(["listacotizaciones"]);
  }

  Future<bool> storeCotizacion({String obs, String fecha, String tiempodias, int idvehiculo, List<Map<String, dynamic>> servicioss, double umbral}) async {

    Map<String, dynamic> map ={
      "id_cotizacion"  : "${cotizaciones.length + 10}",
      "observacion"    : obs,
      "fecha"          : fecha,
      "tiempo_trabajo" : tiempodias,
      "id_personal"    : '1',
      "id_vehiculo"    : idvehiculo.toString(),
      "servicioss"     : json.encode(servicioss)
    };

    var res = await instance.storeCotizacion(map);
    this.getCotizaciones();
    return res;
  }




}