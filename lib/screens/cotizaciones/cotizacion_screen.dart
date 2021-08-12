
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/cotizacion_controller.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/screens/cotizaciones/create_cotizacion_screen.dart';
import 'package:ingemec/screens/cotizaciones/edit_cotizacion_screen.dart';
import 'package:ingemec/screens/cotizaciones/nueva_cotizacion_screen.dart';
import 'package:ingemec/screens/cotizaciones/widgets/cotizacion_item.dart';
import 'package:ingemec/screens/works/works_screen.dart';
import 'package:ingemec/widgets/subcajita.dart';

class CotizacionScreen extends StatelessWidget {


  final _style = TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {

    var quote = Get.put(QuotesController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleWithRefreshButton(title: 'Cotizaciones',
              onPressed: () => quote.getAllCotizaciones(),
            ),
            // Text('COTIZACIONES REGISTRADAS', style: _style),
            SizedBox(height : 15),
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
      // onPressed: () => Get.to(() => CreateCotizacionScreen())
      onPressed: () => Get.to(() => NuevaCotizacionScreen())
    );
  }

  Widget _bodyCotizacionC() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child:  Container(
        height: Get.height * 0.85,
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
          final cot = Get.put(QuotesController());
          var res = await cot.instance.deleteCotizacion({
            "id_cotizacion":item.idCotizacion.toString()
          });
          if(res){
            Get.back();
          }else{
            Get.snackbar("Ups! Algo salió mal!", "No se pudo eliminar la cotizacion");
          }
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