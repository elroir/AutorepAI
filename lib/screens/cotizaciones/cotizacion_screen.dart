
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/cotizacion_controller.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/screens/cotizaciones/cotizacion_history.dart';
import 'package:ingemec/screens/cotizaciones/edit_cotizacion_screen.dart';
import 'package:ingemec/screens/cotizaciones/nueva_cotizacion_screen.dart';
import 'package:ingemec/screens/cotizaciones/widgets/cotizacion_item.dart';
import 'package:ingemec/screens/works/works_screen.dart';
import 'package:ingemec/widgets/card_button.dart';

class CotizacionScreen extends StatefulWidget {

  @override
  _CotizacionScreenState createState() => _CotizacionScreenState();
}

class _CotizacionScreenState extends State<CotizacionScreen> {
  
  final quote = Get.put(QuotesController());

  @override
  void initState() {
    quote.getAllCotizaciones();
    quote.getActiveQuotesWithVehicle();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleWithRefreshButton(title: 'Mis Cotizaciones',
              onPressed: () => quote.getAllCotizaciones(),
            ),
            // Text('COTIZACIONES REGISTRADAS', style: _style),
            SizedBox(height : 15),
            _bodyCotizacionC(),
            Center(
              child: CardButton(
                width: Get.width*0.9,
                icon: FeatherIcons.bookOpen,
                text: 'Historial de cotizaciones',
                onPressed: () => Get.to(()=> QuotesHistory()),
              ),
            ),
            SizedBox(height : 15),


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
        height: Get.height * 0.52,
        child:  GetBuilder<QuotesController>(
        init: QuotesController(),
        id: 'listacotizaciones',
        builder: (lcontroller) => ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: lcontroller.cotizaciones.length ,
          itemBuilder:(_, index) {
            Cotizacion item = lcontroller.cotizaciones[index];
            print(item.vehiculo.nroPlaca);
            print(item.vehiculo.idUsuario);
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
          var res = await quote.instance.deleteCotizacion({
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