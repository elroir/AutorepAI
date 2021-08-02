
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/cotizacion_controller.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/screens/cotizaciones/create_cotizacion_screen.dart';
import 'package:ingemec/screens/cotizaciones/otro.dart';
import 'package:ingemec/widgets/bottom_item.dart';
import 'package:ingemec/widgets/subcajita.dart';

class CotizacionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SubcajitaWidget(
              title: 'Cotizaciones', 
              subtitle: 'Cotizaciones Registradas', 
              colorCajitaP: Color(0xFFE85F5F),
              color: Color(0xff728AC1)),
            // _bodyCotizacion(),
            _bodyCotizacionC()
            
          ],
        ),
      ),
      floatingActionButton: _floatingButton(),
    );
  }

  Widget _floatingButton(){
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: (){
        Get.to(() => CreateCotizacionScreen( ));
        // Get.to(() => DatePickerDemo());
      }
    );
  }

  Widget _bodyCotizacion() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: Get.height * 0.7,
        child: SingleChildScrollView(
          child: Column(
            children: [
            
            _cotizacionItem(),
            _cotizacionItem(),
            _cotizacionItem(),
            _cotizacionItem(),
              
            ],
          ),
        ),
      ),
    );
  }
  Widget _bodyCotizacionC() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child:  Container(
        height: Get.height * 0.7,
        child:  GetBuilder<CotizacionController>(
        init: CotizacionController(),
        id: 'listacotizaciones',
        builder: (lcontroller) => ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: lcontroller.cotizaciones.length ,
          itemBuilder:(_, index) {
            Cotizacion item = lcontroller.cotizaciones[index];
            return  _cotizacionItemC(item);
          },
        )
        ),
      ),
    );
  }

   FadeInLeft _cotizacionItemC( Cotizacion item) {
    return FadeInLeft(
      duration: Duration( milliseconds: 250 ),
      child: Dismissible(
        key : UniqueKey(),
        onDismissed: (direction) async {
          print('bye');
        },
        background: Container(color: Colors.red),
        child: BotonItem(
          texto: "${item.observacion}",
          color1: Color(0xFF535f9b),
          color2: Color(0xFF535f9b),
          onPress: () {
            // Get.to(() => EditServiceScreen( item ));
          },
        ),
      ),
    );
  }
   FadeInLeft _cotizacionItem() {
    return FadeInLeft(
      duration: Duration( milliseconds: 250 ),
      child: Dismissible(
        key : UniqueKey(),
        onDismissed: (direction) async {
          print('bye');
        },
        background: Container(color: Colors.red),
        child: BotonItem(
          texto: "item.observacion",
          color1: Color(0xFF535f9b),
          color2: Color(0xFF535f9b),
          onPress: () {
            // Get.to(() => EditServiceScreen( item ));
          },
        ),
      ),
    );
  }

  Widget _bodyCotizacion2() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff728AC1),
          borderRadius: BorderRadius.circular(25)
        ),
        height: Get.height * 0.7,
        child: SingleChildScrollView(
          child: Column(
            children: [
            
            _cotizacionItem(),
            _cotizacionItem(),
            _cotizacionItem(),
            _cotizacionItem(),
              
            ],
          ),
        ),
      ),
    );
  }
}