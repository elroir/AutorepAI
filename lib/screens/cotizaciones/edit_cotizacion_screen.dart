import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/screens/services/create_service_screen.dart';
import 'package:ingemec/widgets/bottom_submit.dart';
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
      body: Container(
        width: Get.width,
        child: Column(
          children: [
            Text('ACTUALIZAR COTIZACION', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:22)
            ),
            SizedBox(height: 15),
            ColorBoxDecoration(
              color: Color(0xff535f9b),
              height: Get.height * 0.8,
              child: Container(
                width: Get.width * 0.85,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _cotizacionFormPage(widget.cotizacion),
                      SizedBox(height: 10),
                      BotonSubmit(
                        color: Colors.pinkAccent, 
                        texto: "Actualizar", 
                        onPress: (){}
                      )

                    ],
                  ),
                ),
              )
            )
          ],
        ),
      )
    );
  }

  Widget _cotizacionFormPage(Cotizacion cotizacion) {
    return Padding(
      padding: EdgeInsets.symmetric( horizontal: 17 ),
      child: Form(
          child: Column(
            children: [
              Text('Datos de la proforma', style: _titleStyle),
              SizedBox(height: 15),

              TextFormField(
                initialValue: cotizacion.observacion,
                validator: (value) => value.isEmpty ? 'Observacion' : null,
                cursorColor: Colors.white,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  labelText: 'Observacion',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  hintText: 'Arreglar ... ',
                ),
              ),
              SizedBox(height: 8),

              TextFormField(
                initialValue: cotizacion.tiempoTrabajo.toString(),
                validator: (value) => value.isEmpty ? 'Tiempo de trabajo (dias)' : null,
                cursorColor: Colors.white,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  labelText: 'Tiempo de trabajo (dias)',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  hintText: '10 dias ',
                ),
              ),
              SizedBox(height: 8),

              TextFormField(
                initialValue: "${cotizacion.fecha.year}-${cotizacion.fecha.month}-${cotizacion.fecha.day}",
                validator: (value) => value.isEmpty ? 'Fecha' : null,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  labelText: 'Fecha',
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                  hintText: '2021-08-12 ',
                ),
              ),
              SizedBox(height: 8),
            ],
          )
        ),
      );
    }
}