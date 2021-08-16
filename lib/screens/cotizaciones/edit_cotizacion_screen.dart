import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/cotizacion_controller.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/models/service_model.dart';
import 'package:ingemec/screens/cotizaciones/imports_cotizacion.dart';
import 'package:ingemec/widgets/bottom_item.dart';
import 'package:ingemec/widgets/bottom_submit.dart';
import 'package:ingemec/widgets/custom_text_field.dart';

class EditCotizacionScreen extends StatefulWidget {

  final Cotizacion cotizacion;

  EditCotizacionScreen(this.cotizacion);

  @override
  _EditCotizacionScreenState createState() => _EditCotizacionScreenState();
}

class _EditCotizacionScreenState extends State<EditCotizacionScreen> {

  TextEditingController obsController = new TextEditingController();
  TextEditingController tiempoController = new TextEditingController();
  TextEditingController fechaController = new TextEditingController();
  
  
  final _formKey = GlobalKey<FormState>();

  TextStyle _titleStyle =  TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  String observacion = '', fecha = '';
  int tiempoTrabajo = 0;

  List<Service> registrar = [];
  List<Service> eliminar = [];

  int currentI = 0;

  @override
  Widget build(BuildContext context) {
    var cot = Get.put(QuotesController());
    setState(() {
      cot.setCotizacion = widget.cotizacion;
    });
    
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
                  _misServiciosPage(widget.cotizacion.servicios),
                  _noServiciosList(widget.cotizacion.noservicios)
                   
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
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 12),
            Text('Datos de la proforma', style: _titleStyle),
            SizedBox(height: 15),
            
            CustomTextField(
              
              labelText: 'Observacion',
              initialValue: cotizacion.observacion,
              onSaved: (valor) => setState(() => observacion = valor),
              icon: Icon(Icons.lock_clock),
            ),
            SizedBox(height: 8),

            CustomTextField(
              labelText: 'Tiempo de trabajo',
              initialValue: cotizacion.tiempoTrabajo.toString(),
              onSaved: (valor) => setState(() => tiempoTrabajo = int.tryParse(valor) ?? 10),
              icon: Icon(Icons.lock_clock),
              inputType: TextInputType.number,
            ),
            SizedBox(height: 8),

            CustomTextField(
              labelText: 'Fecha',
              initialValue: "${cotizacion.fecha.year}-${cotizacion.fecha.month}-${cotizacion.fecha.day}",
              onSaved: (valor) => setState(() => fecha = valor),
              inputType: TextInputType.datetime,
              icon: Icon(Icons.date_range),
            ),
            SizedBox(height: 12)
          ],
        )
      ),
    );
  }


 
  Widget _misServiciosPage(List<Service> servicios) {
    return   Column(
      children: [
        Text('Seleccionar los servicios que requiera eliminar:' , style: _titleStyle,),
        SizedBox( height: 20),
        Container(
          height: Get.height * 0.38,
          child:  ListView.builder(
            itemCount: servicios.length,
            itemBuilder: (_, index){
              return BotonItem(
                color1: Color(0xff486090),
                color2: Color(0xff486090),
                // color1: Colors.blue[400],
                // color2: Colors.blue,
                onPress: (){
                  setState(() {
                    eliminar.add(servicios[index]);
                    print('length eliminar = ${eliminar.length}');
                  });
                },
                texto: servicios[index].nombre,
              );
            }
          )
        )
      ],
    );
  }
  Widget _noServiciosList(List<Service> servicios) {
    return   Column(
      children: [
        Text('Seleccionar los servicios que requiera añadir:' , style: _titleStyle,),
        SizedBox( height: 20),
        Container(
          height: Get.height * 0.6,
          child:  ListView.builder(
            itemCount: servicios.length,
            itemBuilder: (_, index){
              return BotonItem(
                color1: Color(0xff535f9b),
                color2: Color(0xff535f9b),
                onPress: (){
                  setState(() {
                    registrar.add(servicios[index]);
                    print('length registrar = ${registrar.length}');
                  });
                },
                texto: servicios[index].nombre,
              );
            }
          )
        ),
        SizedBox(height: 10),
        BotonSubmit(
          color: Colors.pinkAccent, 
          texto: "Actualizar", 
          onPress: _guardar
        )
      ],
    );
  }
  void _guardar() async {
      final FormState form = _formKey.currentState;
      if (!form.validate()) return;
      form.save();

      print('observacion = $observacion');
      print('tiempoTrabajo = $tiempoTrabajo');
      print('fecha = $fecha');
      //Get.back();
      var sCoti = Get.put(QuotesController());

      print('Actualizando...');

      List<Map<String, dynamic>> servicioss = [];

        for (var item in registrar) {

          Map<String, dynamic> servicio = {
            "id_servicio"  : item.idservicio,
            "precio_venta" : item.precio, // * el umbral puede ser lol, aunque creo que eso lo hago en el back
            "descripcion"  : 'Ninguna',
            "umbral"       : 0.11
          };
          print(servicio);
          print('======');
          servicioss.add(servicio);
      }


      var res = await sCoti.actualizarCotizacion(
      
        idCotizacion : widget.cotizacion.idCotizacion,
        tiempo : (tiempoTrabajo > 0) ? tiempoTrabajo :widget.cotizacion.tiempoTrabajo,
        obs: (observacion.length > 0 )? observacion : widget.cotizacion.observacion,
        fecha: new DateFormat("yyyy-MM-dd").format(DateTime.now()),
        registrar: servicioss,
        eliminar: eliminar
      );
      if(res){
        Get.back();
      }else{
        Get.snackbar("Ups! Algo salió mal!", "No se pudo actualizar la cotizacion");
      }
    }

}