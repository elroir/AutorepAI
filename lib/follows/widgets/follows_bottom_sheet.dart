
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/images_controller.dart';
import 'package:ingemec/models/follow_model.dart';
import 'package:ingemec/screens/cotizaciones/imports_cotizacion.dart';
import 'package:ingemec/services/follows_service.dart';
import 'package:ingemec/widgets/custom_button.dart';
import 'package:ingemec/widgets/custom_text_field.dart';

class FollowsBottomSheet extends StatelessWidget {

  final int idOrder;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _date        = TextEditingController();

  FollowsBottomSheet({Key key, this.idOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return GetBuilder<ImageController>(
      init: ImageController(),
      id: 'images',
      builder: (controller) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: this._formKey,
            child: Column(
              children: [
                SizedBox(height: 25),
                controller.currentImage!=null
                ?  Image.file(controller.currentImage,width: 250,height: 200,fit: BoxFit.contain,)
                : SizedBox(
                  width: 250,
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(FeatherIcons.image,size: 80,color: Colors.grey,),
                      Text('Elegir desde',style: TextStyle(fontSize: 20),)
                    ],
                  ),
                ),

                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        onPressed: () async {
                          await controller.pickFromGallery();
                        },
                        width: size.width*0.42,
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
                          await controller.pickFromCamera();
                        },
                        width: size.width*0.42,
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
                  color: Theme.of(context).primaryColorDark,
                  controller: _description,
                  labelText: 'Detalle',
                ),
                CustomTextField(
                  color: Theme.of(context).primaryColorDark,
                  inputType: TextInputType.datetime,
                  controller: _date,
                  labelText: 'Fecha',
                ),
                SizedBox(height: 25),
                CustomButton(
                  child: Text('Enviar Seguimiento'),
                  onPressed:() async {
                    final FormState form = _formKey.currentState;
                    if (!form.validate()) return;
                    form.save();
                    Get.dialog(Center(child: CircularProgressIndicator.adaptive(),));
                    final format = DateFormat('dd/MM/yyyy');
                    final DateTime date = format.parse(this._date.text);
                    await controller.uploadPhoto();
                    Follow follow = Follow(
                      idOrder: this.idOrder,
                      description: this._description.text,
                      date: date,
                      imageUrl: 'adasdsad'
                    );
                    await FollowsService.instance.newFollow(follow);
                    Get.back();
                  },
                ),
                SizedBox(height: 20),


              ],
            ),
          ),
        );
      },
    );
  }
}
