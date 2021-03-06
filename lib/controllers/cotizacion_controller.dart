


import 'dart:convert';

import 'package:get/get.dart';
import 'package:ingemec/controllers/auth_controller.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/models/service_model.dart';
import 'package:ingemec/services/cotizacion_service.dart';

class QuotesController extends GetxController{

  CotizacionService instance = CotizacionService.instance;

  List<Cotizacion> _cotizaciones = [];
  Cotizacion _cotizacion = new Cotizacion();

  List<Cotizacion> _history;
  List<Cotizacion> get history => this._history;

  List<Cotizacion> _activeQuotes;

  List<Cotizacion> get cotizaciones => _cotizaciones;
  Cotizacion get cotizacion => _cotizacion;

  set setCotizacion(Cotizacion c) => _cotizacion = c;

  List<Cotizacion> get activeQuotes => this._activeQuotes;
  
  bool _loading = true;
  bool get loading  => this._loading;

  bool _loadingHistory = true;
  bool get loadingHistory  => this._loadingHistory;


  @override
  void onReady() {
    this.getAllCotizaciones();
    this.getActiveQuotesWithVehicle();
    this.loadHistory();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();

  }

  Future<List<Cotizacion>> _getQuotes() async {
    final AuthController auth = Get.find();
    List<Cotizacion> temporalQuotes = [];
    if (auth.userType=='A')
      temporalQuotes = await instance.getAllCotizaciones();
    else
      temporalQuotes = await instance.getAllPersonalCotizaciones(auth.userId);

    return temporalQuotes;
  }

  void getActiveQuotesWithVehicle() async {
    this._loading = true;
    update(['activeQuotes']);
    List<Cotizacion> temporalQuotes = await this._getQuotes();
    this._activeQuotes = temporalQuotes.where((quote) => !quote.aprobado&&quote.estado).toList();
    this._loading = false;
    update(['activeQuotes']);
  }

  Future<void> loadHistory() async {
    this._loadingHistory = true;
    update(['history']);
    final AuthController auth = Get.find();
    if (auth.userType=='A')
      this._history = await CotizacionService.instance.getCotizacionHistory();
    else
      this._history = await CotizacionService.instance.getCotizacionHistory(id: auth.userId);

    this._loadingHistory = false;
    update(['history']);
  }

  void changeQuoteState(Cotizacion quote){
    this._activeQuotes.removeWhere((q) => q.idCotizacion==quote.idCotizacion);
    update(['activeQuotes']);
  }

  Future<bool> storeCotizacion({String obs, String fecha, String tiempodias, int idvehiculo, List<Map<String, dynamic>> servicioss, String urlImagen}) async {

    var auth = Get.put(AuthController());
    print(auth.userId);
    int length = await CotizacionService.instance.quoteLength(); 

    Map<String, dynamic> map ={
      "id_cotizacion"  : length.toString(),
      "observacion"    : obs,
      "fecha"          : fecha,
      "tiempo_trabajo" : tiempodias,
      "id_personal"    : auth.userId,
      "id_vehiculo"    : idvehiculo.toString(),
      "url_imagen"     : urlImagen,
      "servicioss"     : json.encode(servicioss)
    };

    print(map.toString());

    var res = await instance.storeCotizacion(map);
    // this.getQuotes();
    this.getAllCotizaciones();
    return res;
    // return false;
  }

  void getAllCotizaciones() async {

    this._cotizaciones = await this._getQuotes();

    update(['listacotizaciones']);
  }

  Future<bool> actualizarCotizacion({int idCotizacion, int tiempo, String obs, String fecha, List<Map<String, dynamic>> registrar, List<Service> eliminar}) async {
    Map<String, dynamic> ncotizacion = {
      "id_cotizacion" : idCotizacion.toString(),
      "tiempo_trabajo" : tiempo.toString(),
      "observacion" : obs,
      "fecha" : fecha,
      "registrar" : json.encode(registrar),
      "eliminar" : json.encode(eliminar),
    };

    print(json.encode(ncotizacion));

    var sw = await this.instance.actualizarCotizacion(ncotizacion);

    this.getAllCotizaciones();
    return sw;
    // return false;
  }

  void destroy() {
    this._loading = true;
    this._activeQuotes.clear();
    this._cotizaciones.clear();
    update();
  }

}