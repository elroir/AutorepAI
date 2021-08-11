import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/cotizacion_controller.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/models/service_model.dart';
import 'package:ingemec/widgets/bottom_item.dart';
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

  String observacion = '', fecha = '';
  int tiempoTrabajo = 0;

  List<Service> registrar = [];
  List<Service> eliminar = [];

  int currentI = 0;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _actualizarForm(),
      bottomNavigationBar: _bottomNavBar(),
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
                 children: [ _escogerWidget()],
               ),
             ),
           )
        ],
      ),
    );
  }


  Widget _bottomNavBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      currentIndex: currentI,
      // backgroundColor: Color(0xff1e6793),
      backgroundColor: Color(0xff392F8B),
      onTap: (value) => setState(() => currentI = value),
      items: <BottomNavigationBarItem> [
       
        BottomNavigationBarItem( icon: Icon(Icons.car_rental), label: 'Cotizacion' ),
        BottomNavigationBarItem( icon: Icon(Icons.dangerous), label: 'Mis Servicios' ),
        BottomNavigationBarItem( icon: Icon(Icons.addchart), label: 'Más Servicios' ),
      ],
    );
  }

  // ignore: missing_return
  Widget _escogerWidget(){
    
    switch (currentI) {
      case 0 : return _cotizacionFormPage(widget.cotizacion);
      case 1 : return _misServiciosPage(widget.cotizacion.servicios);
      case 2 : return _noServiciosList(widget.cotizacion.noservicios);
       
    }
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
                onSaved: (valor) => setState(() => observacion = valor),
                icon: Icon(Icons.lock_clock),
                // inputType: TextInputType.number,
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
          height: Get.height * 0.6,
          child:  ListView.builder(
            itemCount: servicios.length,
            itemBuilder: (_, index){
              return BotonItem(
                color1: Colors.blue[400],
                color2: Colors.blue,
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
          onPress: () async {
            var sCoti = Get.put(QuotesController());


            await sCoti.actualizarCotizacion(
            
              idCotizacion : widget.cotizacion.idCotizacion,
              tiempo : tiempoTrabajo,
              obs: observacion,
              registrar: registrar,
              eliminar: eliminar
            );
            print('deberia actualizar');
          }
        )
      ],
    );
  }
}