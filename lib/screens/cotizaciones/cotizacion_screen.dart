
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/cotizacion_controller.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/screens/cotizaciones/create_cotizacion_screen.dart';
import 'package:ingemec/screens/cotizaciones/edit_cotizacion_screen.dart';
import 'package:ingemec/screens/cotizaciones/widgets/cotizacion_item.dart';
import 'package:ingemec/widgets/subcajita.dart';

class CotizacionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            SubcajitaWidget(
              title: 'General', 
              subtitle: 'COTIZACIONES', 
              colorCajitaP: Color(0xFFE85F5F),
              color: Color(0xff728AC1)
            ),

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
      onPressed: () => Get.to(() => CreateCotizacionScreen())
    );
  }

  Widget _bodyCotizacionC() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child:  Container(
        height: Get.height * 0.7,
        child:  GetBuilder<QuotesController>(
        init: QuotesController(),
        id: 'listacotizaciones',
        builder: (lcontroller) => ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: lcontroller.cotizaciones.length ,
          itemBuilder:(_, index) {
            Cotizacion item = lcontroller.cotizaciones[index];
            return _cotizacionItem(item);
          },
        )
        ),
      ),
    );
  }

  FadeInLeft _cotizacionItem(Cotizacion item) {
    return FadeInLeft(
      duration: Duration( milliseconds: 250 ),
      child: Dismissible(
        key : UniqueKey(),
        onDismissed: (direction) async {
          print('Eliminando cotizacion....');
        },
        background: Container(color: Colors.red,),
        child: Container(
          width: Get.width,
          child: CotizacionItem(
            cotizacion : item,
            onPressed: () => Get.to(() => EditCotizacionScreen( item ))
          ),
        ),
      ),
    );
  }
}