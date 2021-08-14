

import 'package:get/get.dart';
import 'package:ingemec/controllers/auth_controller.dart';
import 'package:ingemec/models/work_order_model.dart';
import 'package:ingemec/services/works_service.dart';
import 'package:ingemec/utils/date_utils.dart';

class WorksController extends GetxController{

    List<WorkOrder> _orders;
    List<WorkOrder> get orders => this._orders;

    List<WorkOrder> _history;
    List<WorkOrder> get history => this._history;

    bool _loading = true;
    bool get loading  => this._loading;

    bool _loadingHistory = true;
    bool get loadingHistory  => this._loadingHistory;


    @override
    void onReady()  {
      this.loadWorks();
      this.loadHistory();
      super.onReady();
    }

    void changeOrdersState(WorkOrder order){
      final String finishingDate = dateToFormat(order.fechaEntrega);

      this._orders.removeWhere((w) => w.idOrden==order.idOrden);
      WorksService.instance.updateOrkOrder(order.idOrden, finishingDate, false);
      update(['works']);
    }

    Future<void> loadHistory() async {
      this._loadingHistory = true;
      update(['history']);
      final AuthController auth = Get.find();
      if (auth.userType=='A')
        this._history = await WorksService.instance.getHistoryWorks();
      else
        this._history = await WorksService.instance.getHistoryWorks(id: auth.userId);

      this._loadingHistory = false;
      update(['history']);
    }

    Future<void> loadWorks() async {
      this._loading = true;
      update(['works']);
      final AuthController auth = Get.put(AuthController());
      if (auth.userType=='A')
        this._orders = await WorksService.instance.getWorks();
      else
        this._orders = await WorksService.instance.getPersonalWorks(auth.userId);

      this._loading = false;
      update(['works']);
    }




}