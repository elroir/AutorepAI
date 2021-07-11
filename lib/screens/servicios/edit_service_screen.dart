import 'package:flutter/material.dart';
import 'package:ingemec/models/service_model.dart';
import 'package:ingemec/widgets/bottom_item.dart';

// ignore: must_be_immutable
class EditServiceScreen extends StatelessWidget {
  
  final Service service;
  
  EditServiceScreen( { this.service });

  TextEditingController nombreController = new TextEditingController();
  TextEditingController precioController = new TextEditingController();
  TextEditingController tipoIdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    

    void submitAction(){
      
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:  Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:EdgeInsets.symmetric(vertical: 15.0),
                child: Text('Registrar Servicio', style: TextStyle(fontSize: 30),),
              ),
              Container(
                // width: double.infinity,
                height: 350, //220
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.lightBlue
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Form(
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
                        SizedBox(height: 5,),
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
                        SizedBox(height: 5,),
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

                        // BotonItem(
                        //   // imageSource: 'assets/mec-icon.png',
                        //   texto: 'Actualizar',
                        //   color1: Colors.grey,
                        //   color2: Colors.grey,
                        //   onPress: submitAction,
                        // ),
                      ],

                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // body: Container(
      //   child: Center(
      //     child: Text('edit holi ${this.service.nombre}')
      //   )
      // ),
    );

    
  }
}