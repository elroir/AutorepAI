//import 'package:flutter/material.dart';
//import 'package:get/get.dart';
//import 'package:ingemec/controllers/user_controller.dart';
//import 'package:ingemec/widgets/custom_text_field.dart';
//
//class BottomList extends StatelessWidget {
//
//  final TextEditingController textController;
//  final String label;
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    return  GestureDetector(
//      onTap: () => showModalBottomSheet(
//          backgroundColor: Theme.of(context).cardColor,
//          context: context,
//          builder: (_) {
//            return GetBuilder<UserController>(
//                id: 'user',
//                init: UserController(),
//                builder: (controller){
//                  if(!controller.loading){
//                    return ListView.builder(
//                        physics: BouncingScrollPhysics(),
//                        itemCount: controller.users.length,
//                        itemBuilder: (_,i) => ListTile(
//                          onTap: () {
//                            this.textController.text = controller.users[i].nombre;
//                            Get.back();
//                          },
//                          title: Text(controller.users[i].nombre,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
//                        )
//
//                    );
//                  }
//                  return SizedBox();
//                }
//
//            );
//          }
//      ),
//      child: CustomTextField(
//        controller: this.textController ,
//        labelText: this.label,
//        enabled: false,
//      ),
//    ),
//  }
//}
