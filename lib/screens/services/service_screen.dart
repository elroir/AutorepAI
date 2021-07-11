
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:ingemec/controllers/page_controller.dart';

import 'package:ingemec/controllers/service_controller.dart';
import 'package:ingemec/models/service_model.dart';
import 'package:ingemec/routes.dart';
import 'package:ingemec/screens/services/create_service_screen.dart';
import 'package:ingemec/screens/services/edit_service_screen.dart';
import 'package:ingemec/screens/services/registrar_screen.dart';
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
    
      // backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            BotonItem(
              texto: "CLICK ME",
              color1: Colors.blue,
              color2: Colors.blue,
              onPress: () {
                pageX.changePage(RouteSPA(index:7,page: RegisterScreen()));
              },
            ),
            Container(
              height: 500,
              child:  GetBuilder<ServiceController>(
              init: ServiceController(),
              id: 'listaservicios',
              builder: (lcontroller) =>
              ListView.builder(
                itemCount: lcontroller.servicios.length ,
                itemBuilder:(_, index) {
                  Service item = lcontroller.servicios[index];
                  // return Text('${lcontroller.servicios[index].nombre}', style: TextStyle(color: Colors.black),);
                return FadeInLeft(
                    duration: Duration( milliseconds: 250 ),
                    child: Dismissible(
                      key : UniqueKey(),
                      onDismissed: (direction) async {
                        print('bye');
                      },
                      background: Container(color: Colors.red),
                      child: BotonItem(
                        // imageSource: 'assets/mec-icon.png',
                        texto: item.nombre,
                        color1: Colors.blue,
                        color2: Colors.blue,
                        onPress: () {
                          //  pageX.changePage(RouteSPA(index:8,page: EditServiceScreen( item )));
                          Get.to(EditServiceScreen( service : item ));
                        },
                      ),
                    ),
                  );
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

  FloatingActionButton _floatingButton() => 
    FloatingActionButton(
      child: Icon(Icons.settings),
      onPressed: _showMyDialog
  );
  

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registrar Servicio'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                CreateServiceScreen()
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Registar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }  

}

