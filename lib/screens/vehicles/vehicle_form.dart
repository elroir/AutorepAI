import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/images_controller.dart';
import 'package:ingemec/controllers/vehicle_controller.dart';
import 'package:ingemec/models/user_model.dart';
import 'package:ingemec/screens/vehicles/widgets/plate_picker.dart';
import 'package:ingemec/widgets/custom_button.dart';
import 'package:ingemec/widgets/custom_text_field.dart';

class VehicleForm extends StatelessWidget {

  final UserModel user;

  VehicleForm({this.user});

  final _formKey = GlobalKey<FormState>();

  final VehicleController _vehicleController = Get.put(VehicleController());

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
              PlatePicker(vehicle: this._vehicleController.vehicle),
              CustomTextField(
                labelText: 'Marca',
                onSaved: (value) {
                  this._vehicleController.vehicle.marca = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextField(
                    width: Get.width*0.45,
                    labelText: 'Color',
                    onSaved: (value) {
                      this._vehicleController.vehicle.color = value;
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
                      this._vehicleController.vehicle.modelo = value;
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
    Get.dialog(Center(child: CircularProgressIndicator.adaptive(),));
    this._vehicleController.vehicle.idUsuario = this.user.idusuario;
    final ImageController imageController = Get.put(ImageController());
    await imageController.uploadPhoto();
    this._vehicleController.vehicle.urlImagen = imageController.url;
    await this._vehicleController.newVehicle();
    Get.back();
    Get.back();


  }

}


