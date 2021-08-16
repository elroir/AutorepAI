import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/works_controller.dart';
import 'package:ingemec/screens/works/widgets/work_item.dart';
import 'package:ingemec/screens/works/works_screen.dart';

class WorksHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: GetBuilder<WorksController>(
          init: WorksController(),
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
                      child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            SizedBox(width: double.infinity,),
                            ...controller.history.map((history) =>
                                FadeInRight(duration: Duration(milliseconds: 700),child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: WorkItem(order: history,onTap: (){
                                    Get.snackbar("Encargado", history.personal.nombre);
                                  },),
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

  Widget _largeScreens(WorksController controller) {
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
          child: WorkItem(order: controller.history[i],onTap: (){},),
        );

      },
    );
  }
}
