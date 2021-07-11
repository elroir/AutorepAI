


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

  @override
  void onInit() {
    
    getServicios();
  }

  void getServicios() async {
    _servicios = await  instance.getServicios();
    update(["listaservicios"]);
  }

  void getServicio(String idservicio) async {
    // _servicio = await instance.getServicio(idservicio);
  }




}