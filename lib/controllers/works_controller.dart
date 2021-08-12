

import 'package:get/get.dart';
import 'package:ingemec/models/work_order_model.dart';
import 'package:ingemec/services/works_service.dart';

class WorksController extends GetxController{

    List<WorkOrder> _orders;
    List<WorkOrder> get orders => this._orders;
    bool _loading = true;
    bool get loading  => this._loading;


    @override
    void onReady()  {
      this.loadWorks();
      super.onReady();
    }

    Future<void> loadWorks() async {
      this._loading = true;
      update(['works']);
      this._orders = await WorksService.instance.getWorks();
      this._loading = false;
      update(['works']);
    }




}