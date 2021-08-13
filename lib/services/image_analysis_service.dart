
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ingemec/services/storage_service.dart';

class ImageAnalysisService{

  static ImageAnalysisService _instance = ImageAnalysisService();
  static ImageAnalysisService get instance => _instance;
  
  final String _dbUrl = "34.132.85.203";


  
  Future<String> subirImagen( File file ) async {
    if (file == null) return '';

    final task = StorageService.uploadFile('images/${DateTime.now()}.jpg', file);

    if (task==null) return '';

    final snapshot = await task.whenComplete(() => null);
    final url = await snapshot.ref.getDownloadURL();

    return url;
  }

  Future<String> analizarDanio(Map<String, dynamic> data) async {

    final urifinal = Uri.http( _dbUrl, '/api/annotateImageUri1', data );
    final resp = await http.get(urifinal);
    final decodedData = json.decode(resp.body); //trasforma en un mapa
   
    print('$decodedData dataS');

    return decodedData["data"]["score"].toString();

  }

   Future<String> analizarDanioN(Map<String, dynamic> data) async {

    final urifinal = Uri.http( _dbUrl, '/api/analyzeImageApi', data );
    final resp = await http.get(urifinal);
    final decodedData = json.decode(resp.body); //trasforma en un mapa
   
    print('$decodedData dataS');

    return decodedData["data"]["score"].toString();

  }

}