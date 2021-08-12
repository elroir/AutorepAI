


import 'dart:convert';

import 'package:get/get.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/models/service_model.dart';
import 'package:ingemec/services/cotizacion_service.dart';

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
    update(['activeQuotes']);
    final List<Cotizacion> temporalQuotes = await instance.getAllCotizaciones();
    this._activeQuotes = temporalQuotes.where((quote) => !quote.aprobado&&quote.estado).toList();
    this._loading = false;
    update(['activeQuotes']);
  }

  void changeQuoteState(Cotizacion quote){
    this._activeQuotes.removeWhere((q) => q.idCotizacion==quote.idCotizacion);
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