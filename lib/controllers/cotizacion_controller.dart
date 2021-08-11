


import 'dart:convert';

import 'package:get/get.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/models/cotizacionc_model.dart';
import 'package:ingemec/models/service_model.dart';
import 'package:ingemec/models/vehicle_model.dart';
import 'package:ingemec/services/cotizacion_service.dart';
import 'package:ingemec/services/vehicle_service.dart';

class QuotesController extends GetxController{

  CotizacionService instance = CotizacionService.instance;

  List<CotizacionC> _cotizaciones = [];
  CotizacionC _cotizacion;

  List<Cotizacion> _activeQuotes;

  List<CotizacionC> get cotizaciones => _cotizaciones;
  CotizacionC get cotizacion => _cotizacion;

  List<Cotizacion> get activeQuotes => this._activeQuotes;
  
  bool _loading = true;
  bool get loading  => this._loading;

  @override
  void onInit() {
    super.onInit();
    this.getAllCotizaciones();
  }

  @override
  void onReady() {
   
    this.getActiveQuotesWithVehicle();
    super.onReady();
  }

  @override
  void onClose() {
    
    super.onClose();

  }

  void getActiveQuotesWithVehicle() async {
    this._loading = true;
    final List<Cotizacion> temporalQuotes = await instance.getCotizaciones();
    final List<Vehicle> vehicles = await VehicleService.instance.getVehicles();
    this._activeQuotes = temporalQuotes.where((quote) => !quote.aprobado&&quote.estado).toList();
    print(this._activeQuotes.length);
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
    // this.getQuotes();
    this.getAllCotizaciones();
    return res;
  }

  void getAllCotizaciones() async {
    
    this._cotizaciones = await instance.getAllCotizaciones();
    print(this._cotizaciones.length);
  
    update(['listacotizaciones']);
  }

  Future<void> actualizarCotizacion({int idCotizacion, int tiempo, String obs, List<Service> registrar, List<Service> eliminar}) async {
    Map<String, dynamic> solicitud = {
      "id_cotizacion" : idCotizacion,
      "tiempo" : tiempo,
      "observacion" : obs,
      "registrar" : json.encode(registrar),
      "eliminar" : json.encode(eliminar),
    };

    print(json.encode(solicitud));

  }


}