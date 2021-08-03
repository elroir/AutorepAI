import 'package:get/get.dart';
import 'package:ingemec/models/vehicle_model.dart';
import 'package:ingemec/services/vehicle_service.dart';

class VehicleController extends GetxController{

  List<Vehicle> _vehicles;
  List<Vehicle> get vehicles => this._vehicles;
  bool _loading = true;
  bool get loading  => this._loading;


  @override
  void onReady()  {
    this.loaVehicles();
    super.onReady();
  }

  Future<void> loaVehicles() async {
    this._vehicles = await VehicleService.instance.getVehicles();
    this._loading = false;
    update(['vehicle']);
  }

  Future<void> reload() async{
    this._loading = true;
    await Future.delayed(Duration(milliseconds: 200));
    this._vehicles.clear();
    await this.loaVehicles();
  }


}