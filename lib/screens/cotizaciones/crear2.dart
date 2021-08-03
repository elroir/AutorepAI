
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/cotizacion_controller.dart';
import 'package:ingemec/widgets/bottom_submit.dart';
import 'package:ingemec/widgets/generalAppBar.dart';
import 'package:intl/intl.dart';

class Crear2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarG(),
      body: Container(
        child: Column(
          children: [
            BotonSubmit(
              color: Colors.blue,
              texto: 'crear', 
              onPress: _crear
            )
          ],
        ),
      ),
    );
  }

  _crear() async {
    
     var sCoti = Get.put(CotizacionController());


      await sCoti.storeCotizacion(
        obs: 'ninguna',
        fecha: new DateFormat("yyyy-MM-dd").format(DateTime.now()),
        tiempodias: '12',
        idvehiculo: 20,
        umbral: 0.1,
        servicioss: []
      );
      
    
  }
}