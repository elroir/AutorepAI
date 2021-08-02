
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:ingemec/controllers/page_controller.dart';

import 'package:ingemec/controllers/service_controller.dart';
import 'package:ingemec/models/service_model.dart';
import 'package:ingemec/screens/services/create_service_screen.dart';
import 'package:ingemec/screens/services/edit_service_screen.dart';
import 'package:ingemec/services/servicio_service.dart';
import 'package:ingemec/widgets/bottom_item.dart';


class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
 
  final instance = ServicioService.instance;
  
  final pageX = Get.put(PageGetXController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Text('SERVICIOS DISPONIBLES', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:22)
            ),
            
            Container(
              height: Get.height * 0.85,
              child:  GetBuilder<ServiceController>(
              init: ServiceController(),
              id: 'listaservicios',
              builder: (lcontroller) => ListView.builder(
                     physics: BouncingScrollPhysics(),
                itemCount: lcontroller.servicios.length ,
                itemBuilder:(_, index) {
                  Service item = lcontroller.servicios[index];
                  return _serviceItem(item);
                },
              )
             ),
            ),
          ],
        ),
      ),
      floatingActionButton: _floatingButton(),
    );
  }

  FadeInLeft _serviceItem(Service item) {
    return FadeInLeft(
      duration: Duration( milliseconds: 250 ),
      child: Dismissible(
        key : UniqueKey(),
        onDismissed: (direction) async {
          print('bye');
        },
        background: Container(color: Colors.red),
        child: BotonItem(
          texto: item.nombre,
          color1: Color(0xFF535f9b),
          color2: Color(0xFF535f9b),
          onPress: () {
            Get.to(() => EditServiceScreen( item ));
          },
        ),
      ),
    );
  }

  FloatingActionButton _floatingButton() => 
    FloatingActionButton(
      child: Icon(Icons.settings),
      onPressed: (){
        Get.to(() => CreateServiceScreen());
      }
  );
    

}

