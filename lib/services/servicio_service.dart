
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:ingemec/models/service_model.dart';

class ServicioService{
  
  static ServicioService _instance = ServicioService();
  static ServicioService get instance => _instance;

  final _dbUrl = '34.132.85.203';

  Future<List<Service>> getServicios( ) async {
    final urifinal = Uri.http( _dbUrl, '/api/getServicios' );
    final resp = await http.get(urifinal);
    final decodedData = json.decode(resp.body); //trasforma en un mapa
   
    print('$decodedData dataS');
    List<dynamic> items = decodedData["data"];
    List<Service> services = [];
    for (var item in items) {
      Service service = serviceFromJson(item);
      services.add(service);
    }

    return services;
  }

}