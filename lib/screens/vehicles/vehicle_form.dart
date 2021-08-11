import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/ml_controller.dart';
import 'package:ingemec/models/user_model.dart';
import 'package:ingemec/models/vehicle_model.dart';
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
              SafeArea(child: Container(),),
              CustomTextField(
                enabled: false,
                labelText: 'Propietario',
                initialValue: this.user.nombre ?? this.user.email,
              ),
              GetBuilder<MLController>(
                init: MLController(),
                id: 'picker',
                builder: (controller){
                  if (controller.image!=null){
                    return Image.file(controller.image,width: 250,height: 200,fit: BoxFit.contain,);
                  }
                  return SizedBox(
                    width: 250,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(FeatherIcons.image,size: 80,color: Colors.grey,),
                        Text('Elegir desde',style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  );
                },

              ),
              GetBuilder<MLController>(
                init: MLController(),
                id: 'vision',
                builder: (controller){
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              onPressed: controller.pickImageFromGallery,
                              width: Get.width*0.42,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Galeria'),
                                  SizedBox(width: 10,),
                                  Icon(FeatherIcons.image)
                                ],
                              ),
                            ),
                            CustomButton(
                              onPressed: controller.pickImageFromCamera,
                              width: Get.width*0.42,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Camara'),
                                  SizedBox(width: 10,),
                                  Icon(FeatherIcons.camera)
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      CustomTextField(
                        controller: TextEditingController(text: controller.result),
                        labelText: 'Placa',
                        onSaved: (value) {
                          this._vehicle.idVehiculo = int.parse(value.substring(0,3));
                          this._vehicle.nroPlaca = value.toUpperCase();
                        },
                        validator: (value) {
                          Pattern pattern = r'^(\d{3,4}[a-zA-Z]{3})$';
                          RegExp plate = RegExp(pattern);
                          if (plate.hasMatch(value))
                            return null;
                          return 'Formato de placa incorrecto';
                        },
                      ),
                    ],
                  );
                },
              ),
              CustomTextField(
                labelText: 'Marca',
                onSaved: (value) {
                  this._vehicle.marca = value;
                },
              ),
//              CustomTextField(
//                labelText: 'Modelo',
//              ),
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
