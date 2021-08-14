
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/models/quote_detail_model.dart';
import 'package:ingemec/models/service_model.dart';
import 'package:ingemec/services/servicio_service.dart';


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

  Future<List<Cotizacion>> getAllPersonalCotizaciones(String id ) async {
    final urifinal = Uri.http( _dbUrl, '/api/getAllCotizacionesP',{
      "id_personal" :  id
    } );
    final resp = await http.get(urifinal);
    final decodedData = json.decode(resp.body);

    print('$decodedData dataS');
    List<dynamic> items = decodedData;
    List<Cotizacion> cotizaciones = [];
    for (var item in items) {
      Cotizacion cotizacion = cotizacionFromJson(item);
      List<QuoteDetail> detalles = listaCDetalles(item["detalles"]);
      List<Service> servicios = ServicioService.instance.listaServicios(item["servicios"]);
      List<Service> noservicios = ServicioService.instance.listaServicios(item["noservicios"]);
      cotizacion.detalles = detalles;
      cotizacion.servicios = servicios;
      cotizacion.noservicios = noservicios;
      cotizaciones.add(cotizacion);
    }

    return cotizaciones;
  }

  Future<List<Cotizacion>> getAllCotizaciones( ) async {
    final urifinal = Uri.http( _dbUrl, '/api/getAllCotizaciones' );
    final resp = await http.get(urifinal);
    final decodedData = json.decode(resp.body);

    print('$decodedData dataS');
    List<dynamic> items = decodedData;
    List<Cotizacion> cotizaciones = [];
    for (var item in items) {
      Cotizacion cotizacion = cotizacionFromJson(item);
      List<QuoteDetail> detalles = listaCDetalles(item["detalles"]);
      List<Service> servicios = ServicioService.instance.listaServicios(item["servicios"]);
      List<Service> noservicios = ServicioService.instance.listaServicios(item["noservicios"]);
      cotizacion.detalles = detalles;
      cotizacion.servicios = servicios;
      cotizacion.noservicios = noservicios;
      cotizaciones.add(cotizacion);
    }

    return cotizaciones;
  }


  Future<bool> storeCotizacion(Map<String, dynamic> data) async {

    final urifinal = Uri.http( _dbUrl, '/api/storeCotizacion', data );
    final resp = await http.post(urifinal, );
    final decodedData = json.decode(resp.body); 
    
    print(decodedData["ok"]);
    // print(decodedData["mensaje"]);
    print(decodedData["data"]);
     return (decodedData["ok"]);
  }

  List<QuoteDetail> listaCDetalles( List<dynamic> items ) {

    List<QuoteDetail> detalles = [];
    for (var item in items) {
      QuoteDetail detalle = QuoteDetail.fromJson(item);
      detalles.add(detalle);
    }

    return detalles;
  }

  Future<bool> deleteCotizacion(Map<String, dynamic> data) async {
    final urifinal = Uri.http( _dbUrl, '/api/deleteCotizacion', data );
    final resp = await http.delete(urifinal );
    final decodedData = json.decode(resp.body); 
    print(decodedData["ok"]);
    // print(decodedData["mensaje"]);
    print(decodedData["data"]);
    return (decodedData["ok"]);
  }

  Future<bool> actualizarCotizacion(Map<String, dynamic> data) async{
    final urifinal = Uri.http( _dbUrl, '/api/actualizarCotizacion', data );
    final resp = await http.get(urifinal );
    final decodedData = json.decode(resp.body); 
    print(decodedData["ok"]);
    // print(decodedData["mensaje"]);
    print(decodedData["data"]);
    return (decodedData["ok"]);
  }
}