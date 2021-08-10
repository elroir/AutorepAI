


import 'dart:convert';

import 'package:get/get.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/models/vehicle_model.dart';
import 'package:ingemec/services/cotizacion_service.dart';
import 'package:ingemec/services/vehicle_service.dart';

class QuotesController extends GetxController{

  CotizacionService instance = CotizacionService.instance;

  List<Cotizacion> _cotizaciones = [];
  Cotizacion _cotizacion;

  List<Cotizacion> _activeQuotes;

  List<Cotizacion> get cotizaciones => _cotizaciones;
  Cotizacion get cotizacion => _cotizacion;

  List<Cotizacion> get activeQuotes => this._activeQuotes;

  bool _loading = true;
  bool get loading  => this._loading;

  @override
  void onInit() {
    super.onInit();
    getQuotes();
  }

  @override
  void onReady() {
    this.getActiveQuotesWithVehicle();
    super.onReady();
  }

  void getQuotes() async {
    _cotizaciones = await instance.getCotizaciones();
    update(["listacotizaciones"]);
  }

  void getActiveQuotesWithVehicle() async {
    this._loading = true;
    final List<Cotizacion> temporalQuotes = await instance.getCotizaciones();
    final List<Vehicle> vehicles = await VehicleService.instance.getVehicles();
    this._activeQuotes = temporalQuotes.where((quote) => quote.aprobado).toList();
    this._activeQuotes.forEach((quote) {
      vehicles.forEach((vehicle) {
        if (quote.idVehiculo==vehicle.idVehiculo)
          quote.vehiculo = vehicle;
      });
    });
    this._loading = false;
    update(['activeQuotes']);
  }

  Future<bool> storeCotizacion({String obs, String fecha, String tiempodias, int idvehiculo, List<Map<String, dynamic>> servicioss, double umbral}) async {


    // List<Map<String, dynamic>> servicioss = [];

    // for (var item in servicios) {

    //     Map<String, dynamic> servicio = {
    //       "id"           : item.idservicio,
    //       "precio_venta" : item.precio, // * el umbral puede ser lol, aunque creo que eso lo hago en el back
    //       "descripcion"  : 'Ninguna',
    //       "umbral"       : umbral
    //     };
    //     print(servicio);
    //     print('======');
    //     servicioss.add(servicio);
    // } 


    Map<String, dynamic> map ={
      "id_cotizacion"  : "${cotizaciones.length + 10}",
      "observacion"    : obs,
      "fecha"          : fecha,
      "tiempo_trabajo" : tiempodias,
      "id_personal"    : '1',
      "id_vehiculo"    : idvehiculo.toString(),
      "servicioss"     : json.encode(servicioss)
      // "servicioss"     : servicioss
    };

    var res = await instance.storeCotizacion(map);
    this.getQuotes();
    return res;
  }




}