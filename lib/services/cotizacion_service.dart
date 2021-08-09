
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ingemec/models/cotizacion_model.dart';


class CotizacionService{
  
  static CotizacionService _instance = CotizacionService();
  static CotizacionService get instance => _instance;

  final _dbUrl = '34.132.85.203';

  Future<List<Cotizacion>> getCotizaciones( ) async {
    final urifinal = Uri.http( _dbUrl, '/api/getCotizaciones' );
    final resp = await http.get(urifinal);
    final decodedData = json.decode(resp.body); 
   
    print('$decodedData dataS');
    List<dynamic> items = decodedData["data"];
    List<Cotizacion> cotizaciones = [];
    for (var item in items) {
      Cotizacion service = cotizacionFromJson(item);
      cotizaciones.add(service);
    }

    return cotizaciones;
  }

  Future<bool> storeCotizacion(Map<String, dynamic> data) async {

    final urifinal = Uri.http( _dbUrl, '/api/storeCotizacion', data );
    final resp = await http.post(urifinal);
    final decodedData = json.decode(resp.body); 
    
    print(decodedData["ok"]);
    // print(decodedData["mensaje"]);
    print(decodedData["data"]);
     return (decodedData["ok"]);
  }

}