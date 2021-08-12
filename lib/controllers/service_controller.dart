


import 'package:get/get.dart';
import 'package:ingemec/models/service_model.dart';
import 'package:ingemec/services/servicio_service.dart';

    // ignore: unnecessary_statements
class ServiceController extends GetxController{

  ServicioService instance = ServicioService.instance;

  List<Service> _servicios = [];
  Service _servicio;

  List<Service> get servicios => _servicios;
  Service get servicio => _servicio;

  bool _loading = false;

  bool get loading => this._loading;
  

  @override
  void onInit() {
    super.onInit();
    getServicios();
  }

  void getServicios() async {
    _servicios = await  instance.getServicios();
    update(["listaservicios"]);
  }

  Future<bool> storeService(String nombre, String precio, String ntipo) async {

    Map<String, dynamic> map ={
      "id_servicio" : "${servicios.length + 1}",
      "nombre" : nombre,
      "precio" : precio,
      "ntipo" : ntipo
    };

    var sw = await instance.storeService(map);
    this.getServicios();
    return sw;

  }




}