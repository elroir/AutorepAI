import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/ml_controller.dart';

class WorksScreen extends StatelessWidget {

  final visionX = Get.put(MLController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(icon: Icon(FeatherIcons.camera), onPressed:() => visionX.pickImageFromCamera()),
                IconButton(icon: Icon(FeatherIcons.image), onPressed: () => visionX.pickImageFromGallery()),
              ],
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
                return Container(
                    height: 250,
                    width: 250,
                    margin: EdgeInsets.only(top: 70),
                    padding: EdgeInsets.only(left: 20,bottom: 5,right: 18),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          controller.result,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Get.theme.cardColor
                    )
                );
              },

            ),
          ],
        ),
      ),
    );
  }
}