
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ingemec/controllers/auth_controller.dart';
import 'package:ingemec/controllers/cotizacion_controller.dart';
import 'package:ingemec/controllers/user_controller.dart';
import 'package:ingemec/controllers/vehicle_controller.dart';
import 'package:ingemec/screens/launcher_screen.dart';
import 'package:ingemec/screens/launcher_screen_phone.dart';
import 'package:ingemec/screens/login/login_screen.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    Get.put(VehicleController());
    Get.put(QuotesController());
    return Obx((){
        return (Get.find<AuthController>().firebaseUser != null)
        ? Get.size.width > 500 ? LauncherScreen() : LauncherScreenPhone() 
        : LoginScreen();

    });
  }
}