import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ingemec/Env.dart';
import 'package:ingemec/models/vehicle_model.dart';

class VehicleService {

  static VehicleService _instance = VehicleService();
  static VehicleService get instance => _instance;

  Future<void> newVehicle(Vehicle vehicle) async {
    try{
      final uri = Uri.http( Env.url, '/api/storeVehiculo', {
        "id_vehiculo" : vehicle.idVehiculo.toString()
      } );
      final resp = await http.post(uri,body: vehicle.toJson());
      final decodedData = json.decode(resp.body);
      if(decodedData['ok'])
        Get.snackbar('Registro existoso', 'Se ha registrado el vehiculo con exito');
      else
        Get.snackbar('Ocurrio un error', 'Ha ocurrido un error, revise su conexión a internet');
    }catch(e){
      Get.snackbar('Ocurrio un error', 'Ha ocurrido un error, revise su conexión a internet');
    }
  }

  Future<List<Vehicle>> getVehicles() async {
    try{
      final uri = Uri.http( Env.url, '/api/getVehiculos' );
      final resp = await http.get(uri);
      final decodedData = json.decode(resp.body);
      final List<Vehicle> vehicles = [];

        (decodedData['data'] as List).forEach((vehicle) {
          vehicles.add(Vehicle.fromJson(vehicle));
        });
        return vehicles;

    }catch(e){
      Get.snackbar('Ocurrio un error', 'Ha ocurrido un error, revise su conexión a internet');
      return [];
    }
  }


}