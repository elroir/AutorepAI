import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/bindings/authBinding.dart';
import 'package:ingemec/root.dart';
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

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Franco Motors',
      debugShowCheckedModeBanner: false,
      theme: Themes.themeData(),
      home: Root(),
      initialBinding: AuthBinding(),
      getPages: [
        GetPage( name: 'root', page: () => Root())
      ],
     
    );
  }
}
