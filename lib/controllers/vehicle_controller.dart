import 'package:get/get.dart';
import 'package:ingemec/models/vehicle_model.dart';
import 'package:ingemec/services/vehicle_service.dart';

class VehicleController extends GetxController{

  List<Vehicle> _vehicles;
  List<Vehicle> get vehicles => this._vehicles;

  Vehicle _vehicle;
  Vehicle get vehicle => this._vehicle;

  bool _loading = true;
  bool get loading  => this._loading;


  @override
  void onReady()  {
    this.loadVehicles();
    this._vehicle = Vehicle();
    super.onReady();
  }

  Future<Map<String,dynamic>> newVehicle() async {
    final Map<String,dynamic> resp = await VehicleService.instance.newVehicle(this._vehicle);
    if(!resp["ok"]) {
      return resp;
    }
    this._vehicles.add(this._vehicle);
    update(['vehicle']);
    return resp;
  }

  Future<void> loadVehicles() async {
    this._vehicles = await VehicleService.instance.getVehicles();
    this._loading = false;
    update(['vehicle']);
  }

  Future<void> reload() async{
    this._loading = true;
    await Future.delayed(Duration(milliseconds: 200));
    this._vehicles.clear();
    await this.loadVehicles();
  }

  void destroy() {
    this._loading = true;
    this._vehicle = Vehicle();
    this._vehicles.clear();
    update();

  }


}