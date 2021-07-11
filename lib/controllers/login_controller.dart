import 'package:get/get.dart';

class LoginController extends GetxController{

  bool _sw;
  String _error;

  @override
  void onInit() {
    this._sw = false;
    this._error = '';
    super.onInit();
  }

  bool   get sw    => this._sw;
  String get error => this._error;

  void setError(String err){
    this._error = err;
  }
  void toggle(){
    this._sw = !this._sw;
    update(['id_sw']);
  }


}