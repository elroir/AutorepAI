import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/cotizacion_controller.dart';
import 'package:ingemec/screens/cotizaciones/widgets/cotizacion_item.dart';
import 'package:ingemec/screens/works/works_screen.dart';

class QuotesHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: GetBuilder<QuotesController>(
          init: QuotesController(),
          id: 'history',
          builder: (controller) {
            if (!controller.loadingHistory){
              return Column(
                children: [
                  SafeArea(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:12),
                    child: TitleWithRefreshButton(
                      title: 'Historial',
                      onPressed: controller.loadHistory,
                    ),
                  ),
                  (Get.width>600)
                      ? this._largeScreens(controller)
                      : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                          children: [
                            SizedBox(width: double.infinity,),
                            ...controller.history.map((history) =>
                                FadeInRight(duration: Duration(milliseconds: 700),
                                    child: Container(
                                      width: Get.width*0.9,
                                      padding: const EdgeInsets.all(10.0),
                                      child: CotizacionItem(cotizacion: history,),
                                ))).toList()
                          ]
                      )
                  )
                ] ,
              ) ;
            }
            return Center(child: CircularProgressIndicator());
          },
        )
    );
  }

  Widget _largeScreens(QuotesController controller) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 350,
          crossAxisSpacing: 5,
          mainAxisExtent: 250,
          mainAxisSpacing: 5,
          childAspectRatio: 0.1

      ),
      itemCount: controller.history.length,
      itemBuilder: (_,i) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: CotizacionItem(cotizacion: controller.history[i]),
        );

      },
    );
  }
}