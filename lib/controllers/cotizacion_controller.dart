


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

  Future<bool> storeService(String nombre, String precio, String tipoId) async {

    Map<String, dynamic> map ={
      // "id_cotizacion" : "${cotizacions.length + 1}",
      // "nombre" : nombre,
      // "precio" : precio,
      // "estado" : "true",
      // "id_tipo" : tipoId
    };

    var sw = await instance.storeCotizacion(map);
    this.getCotizaciones();
    return sw;

  }




}