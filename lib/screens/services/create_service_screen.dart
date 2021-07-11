
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/service_controller.dart';
import 'package:ingemec/widgets/bottom_submit.dart';

// ignore: must_be_immutable
class CreateServiceScreen extends StatelessWidget {
  
  TextEditingController nombreController = new TextEditingController();
  TextEditingController precioController = new TextEditingController();
  TextEditingController tipoIdController = new TextEditingController();

    
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

            Text('REGISTRAR SERVICIO', 
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
                      _createServiceForm(),
                      
                      SizedBox(height: 15),
                      BotonSubmit(
                        color: Color(0xFFdb6060), 
                        texto: "Crear", 
                        onPress: _crearSubmit
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

  Form _createServiceForm() {
    return Form(
        child: Column(
          children: [
            // SizedBox( height: 30.0 ),
            TextFormField(
              controller: nombreController,
              validator: (value) => value.isEmpty ? 'Nombre' : null,
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
              controller: precioController,
              validator: (value) => value.isEmpty ? 'Precio' : null,
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
              controller: tipoIdController,
              validator: (value) => value.isEmpty ? 'Tipo' : null,
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

  void _crearSubmit() async {
    if (nombreController.text != null &&
        precioController.text != null && 
        tipoIdController.text != null  ) {
        
        var sService = Get.put(ServiceController());
        final sw = await sService.storeService(nombreController.text, precioController.text, tipoIdController.text);
        if (sw) {
          Get.back();
        }else{
          print('rayos no se pudo');
        }

    }else{
      print('Falta infor');
    }

  }

  
}

class ColorBoxDecoration extends StatelessWidget {
  
  final Widget child;
  final Color color;
  final double height;
  
  ColorBoxDecoration({ 
    @required this.child, 
    this.color = Colors.red, 
    this.height = 250 
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.circular(50)
      ),  
      child: Padding(
        padding: EdgeInsets.all(25),
        child: this.child
      ),

    );
  }
}