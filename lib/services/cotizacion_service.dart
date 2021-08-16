
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ingemec/Env.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/models/quote_detail_model.dart';
import 'package:ingemec/models/service_model.dart';
import 'package:ingemec/services/servicio_service.dart';


class CotizacionService{
  
  static CotizacionService _instance = CotizacionService();
  static CotizacionService get instance => _instance;

  Future<List<Cotizacion>> getCotizaciones( ) async {
    final urifinal = Uri.http( Env.url, '/api/getCotizaciones' );
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

  Future<List<Cotizacion>> getCotizacionHistory({String id}) async {
    try{
      final uri = (id!=null)
          ?  Uri.http( Env.url, '/api/getAllCotizacionesPH',{
        "id_personal" : id
      } )
          : Uri.http( Env.url, '/api/getAllCotizacionesH' );
      final resp = await http.get(uri);
      final decodedData = json.decode(resp.body);
      final List<Cotizacion> orders = [];

      (decodedData as List).forEach((order) {
        orders.add(Cotizacion.fromJson(order));
      });
      return orders;

    }catch(e){
      return [];
    }
  }

  Future<List<Cotizacion>> getAllPersonalCotizaciones(String id ) async {
    final urifinal = Uri.http( Env.url, '/api/getAllCotizacionesP',{
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

  Future<int> quoteLength() async {
    try{
      final uri = Uri.http( Env.url, '/api/clength' );
      final resp = await http.get(uri);
      final decodedData = json.decode(resp.body);
      return (decodedData['data'] as int) + 1;
    }catch(e){
      print(e);
      return -1;
    }

  }

  Future<List<Cotizacion>> getAllCotizaciones( ) async {
    final urifinal = Uri.http( Env.url, '/api/getAllCotizaciones' );
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

    final urifinal = Uri.http( Env.url, '/api/storeCotizacion', data );
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
    final urifinal = Uri.http( Env.url, '/api/deleteCotizacion', data );
    final resp = await http.delete(urifinal );
    final decodedData = json.decode(resp.body); 
    print(decodedData["ok"]);
    // print(decodedData["mensaje"]);
    print(decodedData["data"]);
    return (decodedData["ok"]);
  }

  Future<bool> actualizarCotizacion(Map<String, dynamic> data) async{
    final urifinal = Uri.http( Env.url, '/api/actualizarCotizacion', data );
    final resp = await http.get(urifinal );
    final decodedData = json.decode(resp.body); 
    print(decodedData["ok"]);
    // print(decodedData["mensaje"]);
    print(decodedData["data"]);
    return (decodedData["ok"]);
  }
}