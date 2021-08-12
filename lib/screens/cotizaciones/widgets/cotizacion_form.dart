
import 'package:flutter/material.dart';
import 'package:ingemec/models/grado_danio_model.dart';
import 'package:ingemec/widgets/custom_text_field.dart';
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

              CustomTextField(
                controller: observacionController,
                validator: (value) => value.isEmpty ? 'Observacion' : null,
                inputType: TextInputType.emailAddress,
                labelText: 'Observacion',
                icon: Icon(Icons.person, color: Colors.white),
              ),
              SizedBox(height: 8),
              CustomTextField(
                controller: tiempoTrabajoController,
                validator: (value) => value.isEmpty ? 'Tiempo de trabajo (dias)' : null,
                inputType: TextInputType.number,
                labelText: 'Tiempo de trabajo (dias)',
                icon: Icon(Icons.person, color: Colors.white),
              ),
              
              SizedBox(height: 8),
              CustomTextField(
                initialValue: new DateFormat("yyyy-MM-dd").format(DateTime.now()), //idk
                validator: (value) => value.isEmpty ? 'Fecha' : null,
                inputType: TextInputType.datetime,
                labelText: 'Fecha',
                icon: Icon(Icons.person, color: Colors.white),
              ),
            
              SizedBox(height: 8),
              CustomTextField(
                initialValue: (gradoDanio.nombre != null) ? '${double.parse(gradoDanio.nombre) * 100} %' : 'lol',
                validator: (value) => value.isEmpty ? 'Grado!' : null,
                labelText: 'Grado de Daño - Porcentaje',
                icon: Icon(Icons.person, color: Colors.white),
              ),
            ],
          )
        ),
    );
  }
}