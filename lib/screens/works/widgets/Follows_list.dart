import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/follows_controller.dart';

class FollowsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FollowController>(
        init: FollowController(),
        id: 'follows',
        builder:(controller) {
          if(!controller.loading){
            return SizedBox(
              width: Get.width,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.white70,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset(
                          'assets/empty.png',
                          width: Get.width*0.85,
                          height: Get.height*0.3,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: Get.width*0.85,
                          height: Get.height*0.1,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black54,
                                    Colors.transparent
                                  ]
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text('No hay seguimientos activos',
                            style: TextStyle(
                                color: Color(0xFFffffff).withOpacity(0.8),
                                fontSize: 16,fontWeight: FontWeight.w700),),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }else
            return CircularProgressIndicator.adaptive();
        }

    );
  }
}
