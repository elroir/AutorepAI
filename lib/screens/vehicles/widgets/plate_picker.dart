import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/images_controller.dart';
import 'package:ingemec/controllers/ml_controller.dart';
import 'package:ingemec/models/vehicle_model.dart';
import 'package:ingemec/widgets/custom_button.dart';
import 'package:ingemec/widgets/custom_text_field.dart';

class PlatePicker extends StatelessWidget {
  const PlatePicker({
    Key key,
    @required Vehicle vehicle,
  }) : _vehicle = vehicle, super(key: key);

  final Vehicle _vehicle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                        onPressed:() async  {
                          final ImageController imageController = Get.put(ImageController());
                          await controller.pickImageFromGallery();
                          imageController.currentImage = controller.image;
                          },
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
                        onPressed: () async {
                          final ImageController imageController = Get.put(ImageController());
                          await controller.pickImageFromCamera();
                          imageController.currentImage = controller.image;
                        },
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
      ],
    );
  }
}