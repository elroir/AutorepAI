


import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class ImageAnalysisService{

  static ImageAnalysisService _instance = ImageAnalysisService();
  static ImageAnalysisService get instance => _instance;
  
  final String _dbUrl = "34.132.85.203";

  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://tallermec-9f2b3.appspot.com');

  
  Future<String> subirImagen( File imagen ) async {
    
    StorageReference _storageRef = _storage.ref().child('images/${DateTime.now()}.jpg');
    
    StorageUploadTask uploadTask = _storageRef.putFile(imagen); 
    await uploadTask.onComplete;    
    print('File Uploaded');    
    String linksito = await _storageRef.getDownloadURL();
    return linksito;
  }

  Future<String> analizarDanio(Map<String, dynamic> data) async {

    final urifinal = Uri.http( _dbUrl, '/api/annotateImageUri1', data );
    final resp = await http.get(urifinal);
    final decodedData = json.decode(resp.body); //trasforma en un mapa
   
    print('$decodedData dataS');

    return decodedData["data"]["score"].toString();

  }

}