
import 'package:flutter/material.dart';

class CreateServiceScreen extends StatefulWidget {
  
  @override
  _CreateServiceScreenState createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  
  TextEditingController nombreController = new TextEditingController();
  TextEditingController precioController = new TextEditingController();
  TextEditingController tipoIdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Container(  
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
          ],
        )
      ),

    );
  }
}