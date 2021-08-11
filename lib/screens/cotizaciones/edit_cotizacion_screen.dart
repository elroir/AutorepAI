import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/cotizacion_controller.dart';
import 'package:ingemec/controllers/service_controller.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/models/cotizacionc_model.dart';
import 'package:ingemec/models/quote_detail_model.dart';
import 'package:ingemec/models/service_model.dart';
import 'package:ingemec/screens/services/create_service_screen.dart';
import 'package:ingemec/services/cotizacion_service.dart';
import 'package:ingemec/widgets/bottom_submit.dart';
import 'package:ingemec/widgets/custom_text_field.dart';
// import 'package:intl/intl.dart';

// ignore: must_be_immutable
class EditCotizacionScreen extends StatefulWidget {

  Cotizacion cotizacion;

  EditCotizacionScreen(this.cotizacion);

  @override
  _EditCotizacionScreenState createState() => _EditCotizacionScreenState();
}

class _EditCotizacionScreenState extends State<EditCotizacionScreen> {

  TextStyle _titleStyle =  TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  TextEditingController observacionController = new TextEditingController();
  TextEditingController tiempoTrabajoController = new TextEditingController();
  TextEditingController fechaController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _actualizarForm(),

    );
  }

  Container _actualizarForm() {
    return Container(
      width: Get.width,
      child: Column(
        children: [
          Text('ACTUALIZAR COTIZACION', 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize:22)
          ),
          SizedBox(height: 15),
          Expanded(
             child: SingleChildScrollView(
               child: Column(
                 children: [
                   _cotizacionFormPage(widget.cotizacion),
                   SizedBox(height: 10),
                   
                   _serviciosPage(),

                  SizedBox(height: 10),
                  
                   SizedBox(height: 10),
                   BotonSubmit(
                     color: Colors.pinkAccent, 
                     texto: "Actualizar", 
                     onPress: ()async {
                       //List<QuoteDetail> la = await CotizacionService.instance.getQuoteDetails(15);
                       List<CotizacionC> la = await CotizacionService.instance.getAllCotizaciones();
                       print('length ${la.length}');
                     }
                   )

                 ],
               ),
             ),
           )
        ],
      ),
    );
  }

  Widget _cotizacionFormPage(Cotizacion cotizacion) {
    return Padding(
      padding: EdgeInsets.symmetric( horizontal: 17 ),
      child: Form(
          child: Column(
            children: [
              SizedBox(height: 12),
              Text('Datos de la proforma', style: _titleStyle),
              SizedBox(height: 15),

              CustomTextField(
                labelText: 'Observacion',
                initialValue: cotizacion.observacion,
                onSaved: (valor){

                },
                icon: Icon(Icons.lock_clock),
                inputType: TextInputType.number,
              ),
              SizedBox(height: 8),

              CustomTextField(
                labelText: 'Tiempo de trabajo',
                initialValue: cotizacion.tiempoTrabajo.toString(),
                onSaved: (valor){

                },
                icon: Icon(Icons.lock_clock),
                inputType: TextInputType.number,
              ),
              SizedBox(height: 8),

              CustomTextField(
                labelText: 'Fecha',
                initialValue: "${cotizacion.fecha.year}-${cotizacion.fecha.month}-${cotizacion.fecha.day}",
                onSaved: (valor){

                },
                inputType: TextInputType.datetime,
                icon: Icon(Icons.date_range),
              ),
              SizedBox(height: 12),
              Text('Servicios', style: _titleStyle),
              SizedBox(height: 15),
              // Container(
              //   height: 80,
              //   child: FutureBuilder<List<QuoteDetail>>(
              //     future: CotizacionService.instance.getQuoteDetails(widget.cotizacion.idCotizacion),
              //     builder: (_, snapshot){
              //       if(snapshot.hasData){
              //         List<QuoteDetail> lista = snapshot.data;
              //         print('length = ${lista.length}');
              //         return Text('omg');
              //       }else{
              //         return CircularProgressIndicator();
              //       }
              //     }
                  
              //   ),
              // ),
            

            ],
          )
        ),
      );
    }

    Widget _serviciosPage() {
    return   Column(
      children: [
        Text('Seleccionar los servicios que requiera:' , style: _titleStyle,),
        SizedBox( height: 20),
        Container(
          height: Get.height * 0.3,
          child:  GetBuilder<QuotesController>(
          init: QuotesController(),
          id: 'listaserviciosupdate',
          builder: (lcontroller) => ListView.builder(
                  physics: BouncingScrollPhysics(),
            itemCount: lcontroller.lista.length ,
            itemBuilder:(_, index) {
              QuoteDetail item = lcontroller.lista[index];
              return Text(item.idServicio.toString());
            },
          )
          ),
        ),
      ],
    );
  }
}