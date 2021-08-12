import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/works_controller.dart';
import 'package:ingemec/models/work_order_model.dart';
import 'package:ingemec/screens/cotizaciones/imports_cotizacion.dart';
import 'package:ingemec/services/works_service.dart';

class WorksDetail extends StatelessWidget {

  final WorkOrder order;

  const WorksDetail({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(child: SizedBox()),
            CustomButton(
              onPressed: () async {
                await WorksService.instance.updateOrkOrder(this.order.idOrden, "2021-08-10", false);
                final orderController = Get.put(WorksController());
                orderController.changeWorkState(this.order);
              },
              child: Text('Eyyyy'),
            )
          ],
        ),
      ),
    );
  }
}
