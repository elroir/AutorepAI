import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/page_controller.dart';
import 'package:ingemec/routes.dart';
import 'package:ingemec/routes2.dart';


class Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      // children: Routes2.instance.routes.map((page) => MenuItem(routeSPA: page,)).toList(),
      children: pageRoutesSPA.map((page) => MenuItem(routeSPA: page,)).toList(),
    );
  }
}



class MenuItem extends StatelessWidget {

final RouteSPA routeSPA;

MenuItem({this.routeSPA});

final PageGetXController pageX = Get.put(PageGetXController());

@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () => pageX.changePage(this.routeSPA),
    child: GetBuilder<PageGetXController>(
      init: PageGetXController(),
      id: 'page',
      builder: (controller) {
        return Container(
          width: 110,
          constraints: BoxConstraints(
              maxHeight: 100,
              minHeight: 80
          ),
          decoration: controller.currentPageIndex==this.routeSPA.index ? BoxDecoration(
              color: Get.theme.cardColor,
              borderRadius: BorderRadius.circular(10)
          ) : null,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(this.routeSPA.icon,size: 56,),
                Text(this.routeSPA.text,style: TextStyle(color: Get.theme.primaryColor,fontSize: 16),)
              ],
            ),
          ),
        );
      }
    ),
  );
}
}
