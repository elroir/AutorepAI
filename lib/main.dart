import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:ingemec/screens/launcher_screen.dart';
import 'package:ingemec/screens/launcher_screen_phone.dart';
import 'package:ingemec/screens/servicios/create_service_screen.dart';
import 'package:ingemec/screens/servicios/edit_service_screen.dart';
import 'package:ingemec/styles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Franco Motors',
      debugShowCheckedModeBanner: false,
      theme: Themes.themeData(),
      home:  Get.size.width > 500 ? LauncherScreen() : LauncherScreenPhone() ,
      getPages: [
        GetPage(name: 'launcher', page:() => LauncherScreen()),
        // GetPage(name: 'edit_service', page:() => EditServiceScreen())
      ]
    );
  }
}
