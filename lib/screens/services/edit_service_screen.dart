import 'package:flutter/material.dart';
// import 'package:get/get.dart';

import 'package:ingemec/models/service_model.dart';
// import 'package:ingemec/controllers/service_controller.dart';
import 'package:ingemec/screens/services/create_service_screen.dart';
import 'package:ingemec/widgets/bottom_submit.dart';

// ignore: must_be_immutable
class EditServiceScreen extends StatefulWidget {
  
  Service service;

  EditServiceScreen(this.service);

  @override
  _EditServiceScreenState createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {

  String nombre, precio, ntipo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Text('ACTUALIZAR SERVICIO', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:22)
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: ColorBoxDecoration(
                color: Color(0xff535f9b),
                height: 325,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 8),

                      SizedBox(height: 8),
                      _updateServiceForm(),
                      
                      SizedBox(height: 15),
                      BotonSubmit(
                        color: Color(0xFFdb6060), 
                        texto: "Actualizar", 
                        onPress: _updateService
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );

    
  }

  Form _updateServiceForm() {
    return Form(
      child: Column(
        children: [
          // SizedBox( height: 30.0 ),
          TextFormField(
            initialValue: widget.service.nombre,
            validator: (value) => value.isEmpty ? 'Nombre' : null,
            onChanged: (value) => setState(() => nombre = value ),
            cursorColor: Colors.white,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              labelText: 'Nombre',
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Arreglar ... ',
            ),
          ),
          SizedBox(height: 5),

          TextFormField(
            initialValue: widget.service.precio.toString(),
            validator: (value) => value.isEmpty ? 'Precio' : null,
            onChanged: (value) => setState(() => precio = value ),
            cursorColor: Colors.white,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              labelText: 'Precio',
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Bs. 15 ',
            ),
          ),
          SizedBox(height: 5),

          TextFormField(
            initialValue: widget.service.ntipo.toString(),
            validator: (value) => value.isEmpty ? 'nTipo' : null,
            onChanged: (value) => setState(() => ntipo = value ),
            cursorColor: Colors.white,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              labelText: 'Tipo',
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Arreglar ... ',
            ),
          ),
        ],
      )
    );
  }

  void _updateService() async {

    if (nombre != null && precio != null && ntipo != null  ) {
        
        // var sService = Get.put(ServiceController());
        // final sw = await sService.updateService(nombre, precio, tipoid);
        // if (sw) {
        //   Get.back();
        // }else{
        //   print('rayos no se pudo');
        // }


    }else{
      print('Falta infor');
    }

  }
}