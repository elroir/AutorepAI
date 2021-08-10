import 'dart:convert';

import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:ingemec/Env.dart';
import 'package:ingemec/models/work_order_model.dart';


class WorksService {

  static WorksService _instance = WorksService();
  static WorksService get instance => _instance;

  Future<List<WorkOrder>> getWorks() async {
    try{
      final uri = Uri.http( Env.url, '/api/getOrdenes' );
      final resp = await http.get(uri);
      final decodedData = json.decode(resp.body);
      final List<WorkOrder> orders = [];

      (decodedData['data'] as List).forEach((order) {
        orders.add(WorkOrder.fromJson(order));
      });
      return orders;

    }catch(e){
      Get.snackbar('Ocurrio un error', 'Ha ocurrido un error, revise su conexión a internet');
      return [];
    }
  }
}