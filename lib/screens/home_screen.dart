import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/auth_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userController = Get.put(AuthController());
    return Scaffold(
      body: Center(
         child: Text(userController.userId)
      ),
    );
  }
}