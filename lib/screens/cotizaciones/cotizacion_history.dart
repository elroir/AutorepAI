import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/cotizacion_controller.dart';
import 'package:ingemec/screens/works/widgets/quotes_card.dart';
import 'package:ingemec/screens/works/works_screen.dart';
import 'package:ingemec/services/user_service.dart';

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
                      title: 'Historial de Cotizaciones',
                      onPressed: controller.loadHistory,
                    ),
                  ),
                  (Get.width>600)
                      ? this._largeScreens(controller)
                      : Expanded(
                        child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                            children: [
                              SizedBox(width: double.infinity,),
                              ...controller.history.map((history) =>
                                  FadeInRight(duration: Duration(milliseconds: 700),
                                      child: Container(
                                        width: Get.width*0.9,
                                        padding: const EdgeInsets.all(10.0),
                                        child: QuotesCard(quote: history, onPressed: () async{
                                          var personal = await UserService.instance.getUser( history.idUsuario);
                                          Get.snackbar("Encargado", personal.nombre);
                                        },),
                                  ))).toList()
                            ]
                        )
                  ),
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
    return Expanded(
      child: GridView.builder(
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
            child: QuotesCard(quote: controller.history[i]),
          );

        },
      ),
    );
  }
}