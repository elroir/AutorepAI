import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/auth_controller.dart';
import 'package:ingemec/screens/cotizaciones/imports_cotizacion.dart';
import 'package:ingemec/widgets/appBarLogo.dart';
import 'package:ingemec/widgets/seguimiento_scroll.dart';
import 'package:ingemec/widgets/subcajita.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    final userController = Get.put(AuthController());
    return Scaffold(
      
      body: Column(
        children: [
          AppBarLogo(size: size),

          FadeInLeft(
            duration: Duration(milliseconds: 1000),
            child: SubcajitaWidget(
              color:Theme.of(context).cardColor ,
              colorCajitaP: Theme.of(context).primaryColor,
              title: 'Inicio', 
              fontSize: 16,
              subtitle: 'Mis seguimientos',
              body: SeguimientosScroll(
                list: [
                  SeguimientoItem(
                    pathImage: 'assets/a1.png',
                    textSubtitle: '12/21',
                  ),
                  SeguimientoItem(
                    pathImage: 'assets/a1.png',
                    textSubtitle: '12/21',
                  ),
                  SeguimientoItem(
                    pathImage: 'assets/a1.png',
                    textSubtitle: '12/21',
                  ),
                  SeguimientoItem(
                    pathImage: 'assets/a1.png',
                    textSubtitle: '12/21',
                  ),
                  
                ],
              ),

              heightBody: 150,
            ),
          ),
          Center(
            child: Text(userController.userId)
          ),
        ],
      ),
    );
  }
}