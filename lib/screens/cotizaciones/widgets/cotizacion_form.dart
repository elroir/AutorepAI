
import 'package:flutter/material.dart';
import 'package:ingemec/models/grado_danio_model.dart';
import 'package:intl/intl.dart';

class CotizacionForm extends StatelessWidget {

  final TextStyle textStyle;
  final TextEditingController observacionController;
  final TextEditingController tiempoTrabajoController;
  final TextEditingController fechaController;

  //Grado
  final GradoDanio gradoDanio;

  const CotizacionForm({
     @required this.observacionController, 
     @required this.tiempoTrabajoController, 
     @required this.fechaController, 
     @required this.gradoDanio, 
     @required this.textStyle
  });

  @override
  Widget build(BuildContext context) {

   return Padding(
      padding: EdgeInsets.symmetric( horizontal: 17 ),
      child: Form(
          child: Column(
            children: [
              Text('Datos de la proforma', style: textStyle),
              SizedBox(height: 15),

              TextFormField(
                controller: observacionController,
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
                controller: tiempoTrabajoController,
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
                initialValue: new DateFormat("yyyy-MM-dd").format(DateTime.now()), //idk
                // controller: vehiculoIdController,
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

              TextFormField(
                initialValue: (gradoDanio.nombre != null) ? '${double.parse(gradoDanio.nombre) * 100} %' : 'lol',
                validator: (value) => value.isEmpty ? 'Grado!' : null,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  labelText: 'Grado de Daño - Porcentaje',
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ],
          )
        ),
    );
  }
}