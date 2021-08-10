


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
    for(int i=0 ; i < this._activeQuotes.length ; i++) {
      vehicles.forEach((vehicle) {
        if (this._activeQuotes[i].idVehiculo == vehicle.idVehiculo)
          this._activeQuotes[i].vehiculo = Vehicle();
          this._activeQuotes[i].vehiculo = vehicle;
      });
    }
    this._loading = false;
    update(['activeQuotes']);
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
    this.getQuotes();
    return res;
  }




}