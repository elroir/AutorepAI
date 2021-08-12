import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/models/user_model.dart';
import 'package:ingemec/models/vehicle_model.dart';
import 'package:ingemec/screens/vehicles/widgets/plate_picker.dart';
import 'package:ingemec/services/vehicle_service.dart';
import 'package:ingemec/widgets/custom_button.dart';
import 'package:ingemec/widgets/custom_text_field.dart';

class VehicleForm extends StatelessWidget {

  final User user;

  VehicleForm({this.user});

  final _formKey = GlobalKey<FormState>();

  final Vehicle _vehicle = new Vehicle();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Nuevo vehiculo'),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: this._formKey,
          child: Column(
            children: [
              SafeArea(child: SizedBox(),),
              CustomTextField(
                enabled: false,
                labelText: 'Propietario',
                initialValue: this.user.nombre ?? this.user.email,
              ),
              PlatePicker(vehicle: _vehicle),
              CustomTextField(
                labelText: 'Marca',
                onSaved: (value) {
                  this._vehicle.marca = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextField(
                    width: Get.width*0.45,
                    labelText: 'Color',
                    onSaved: (value) {
                      this._vehicle.color = value;
                    },
                  ),
                  CustomTextField(
                    width: Get.width*0.4,
                    labelText: 'Año',
                    inputType: TextInputType.numberWithOptions(
                        decimal: false,
                        signed: false
                    ),
                    onSaved: (value) {
                      this._vehicle.modelo = value;
                    },
                  ),
                ],
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

  void _submit() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) return;
    form.save();
    this._vehicle.idUsuario = this.user.idusuario;
    await VehicleService.instance.newVehicle(this._vehicle);


  }

}


