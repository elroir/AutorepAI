import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/works_controller.dart';
import 'package:ingemec/models/work_order_model.dart';
import 'package:ingemec/styles.dart';

class WorksList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorksController>(
        init: WorksController(),
        id: 'works',
        builder:(controller) {
          if(!controller.loading){
            return (controller.orders.isEmpty) ? SizedBox(
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
                          child: Text('No hay ordenes activas',
                            style: TextStyle(
                                color: Color(0xFFffffff).withOpacity(0.8),
                                fontSize: 16,fontWeight: FontWeight.w700),),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
            : _WorkOrdersList(orders: controller.orders,);
          }else
            return Center(child: CircularProgressIndicator.adaptive());
        }

    );
  }


}

class _WorkOrdersList extends StatelessWidget {

  final List<WorkOrder> orders;

  const _WorkOrdersList({Key key, this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return CarouselSlider(
      options: CarouselOptions(
        scrollPhysics: BouncingScrollPhysics()
      ),
      items: this.orders.map((order) =>
          ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: 200,
            width: 220,
            decoration: BoxDecoration(
              color: Get.theme.cardColor
            ),
            child: Column(
              children: [
                Text('Orden nro: ${order.idOrden}',style: TextStyle(fontWeight: FontWeight.w300),),
                Text('Ingreso: ${order.fechaIngreso.day}/${order.fechaIngreso.month}/${order.fechaIngreso.year}' ?? '-',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Get.theme.primaryColor),)
              ],

            ),
          ) ,
        )
      ).toList(),
    );
  }
}

