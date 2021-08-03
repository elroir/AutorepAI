


import 'package:get/get.dart';
import 'package:ingemec/controllers/auth_controller.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/models/service_model.dart';
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
      "id_cotizacion"  : "${cotizaciones.length + 1}",
      "observacion"    : obs,
      "fecha"          : fecha,
      "tiempo_trabajo" : tiempodias,
      "id_personal"    : Get.find<AuthController>().user.idusuario,
      "id_vehiculo"    : idvehiculo,
      "servicioss"     : servicioss
    };

    await instance.storeCotizacion(map);
    this.getCotizaciones();
    return true;
  }




}