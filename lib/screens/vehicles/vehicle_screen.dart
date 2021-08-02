import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/ml_controller.dart';
import 'package:ingemec/models/user_model.dart';
import 'package:ingemec/widgets/custom_button.dart';
import 'package:ingemec/widgets/custom_text_field.dart';

class VehicleScreen extends StatelessWidget {

  final User user;

  VehicleScreen({this.user});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final visionX = Get.put(MLController());


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(icon: Icon(FeatherIcons.camera), onPressed:() => visionX.pickImageFromCamera()),
          IconButton(icon: Icon(FeatherIcons.image), onPressed: () => visionX.pickImageFromGallery()),
        ],
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
                    return Image.file(controller.image,width: 200,height: 250,fit: BoxFit.contain,);
                  }
                  return SizedBox(
                    width: 200,
                    height: 250,
                    child: Icon(FeatherIcons.image,size: 80,color: Colors.grey,),
                  );
                },

              ),
              GetBuilder<MLController>(
                init: MLController(),
                id: 'vision',
                builder: (controller){
//                if(controller.result==''){
//                  Get.snackbar('Sin datos validos','No se encontro una matricula valida');
//                }
                  return Column(
                    children: [

                      CustomTextField(
                        labelText: 'Placa',
                        controller: TextEditingController(text: controller.result),
                      ),
                    ],
                  );
                },
              ),
              CustomTextField(
                labelText: 'Marca',
              ),
              CustomTextField(
                labelText: 'Modelo',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextField(
                    width: Get.width*0.45,
                    labelText: 'Color',
                  ),
                  CustomTextField(
                    width: Get.width*0.4,
                    labelText: 'Año',
                    inputType: TextInputType.numberWithOptions(
                        decimal: false,
                        signed: false
                    ),
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
              SizedBox(height: 25,),

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


  }

}
