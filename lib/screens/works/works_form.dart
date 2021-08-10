import 'package:flutter/material.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/models/work_order_model.dart';
import 'package:ingemec/widgets/custom_button.dart';
import 'package:ingemec/widgets/custom_text_field.dart';

class WorksForm extends StatelessWidget {

  final Cotizacion quote;

  WorksForm({this.quote});

  final _formKey = GlobalKey<FormState>();

  final _order = WorkOrder();

  @override
  Widget build(BuildContext context) {

    final String startDateString = '${this.quote.fecha.day}/${this.quote.fecha.month}/${this.quote.fecha.year}' ?? '-';
    final DateTime endDate = this.quote.fecha.add( Duration(days: this.quote.tiempoTrabajo) );
    final String endDateString = '${endDate.day}/${endDate.month}/${endDate.year}' ?? '-';

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Nueva Orden'),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: this._formKey,
          child: Column(
            children: [
              SafeArea(child: Container(),),
              CustomTextField(
                labelText: 'Fehca de ingreso',
                initialValue: startDateString,
              ),
              CustomTextField(
                labelText: 'Fecha de salida',
                initialValue: endDateString,
                onSaved: (value) {
                  this._order.fechaEntrega = DateTime.parse(value);
                },
              ),
              CustomTextField(
                labelText: 'Personal encargado',
                onSaved: (value) {
                  this._order.fechaEntrega = DateTime.parse(value);
                },
              ),
              SizedBox(height: 25,),
              CustomButton(onPressed: this._submit,
                child: Text('Guardar',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20
                  ),

                ),),
              SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    );

  }

  void _submit(){

  }

}
