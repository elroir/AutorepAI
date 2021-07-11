
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ingemec/controllers/auth_controller.dart';
import 'package:ingemec/screens/launcher_screen.dart';
import 'package:ingemec/screens/launcher_screen_phone.dart';
import 'package:ingemec/screens/login/login_screen.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx((){
        return (Get.find<AuthController>().user != null)
        ? Get.size.width > 500 ? LauncherScreen() : LauncherScreenPhone() 
        : LoginScreen();

    });
  }
}