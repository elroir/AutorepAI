

import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class OrdenTrabajoProvider{
  
  final String _dbUrl = "34.132.85.203";

  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://tallermec-9f2b3.appspot.com');

  void storeOrden( Map<String, String> data ) async {
    
    final url  = Uri.http( _dbUrl, '/api/getOrdenes', data );
    final resp = await http.get(url);

    final decoded = json.decode(resp.body);
    print('========= RESPONSE =============');
    print('========= ${decoded['data']}=============');
  }


  Future<String> subirImagen( File imagen ) async {
    
    StorageReference _storageRef = _storage.ref().child('images/${DateTime.now()}.jpg');
    
    StorageUploadTask uploadTask = _storageRef.putFile(imagen); 
    await uploadTask.onComplete;    
    print('File Uploaded');    
    String linksito = await _storageRef.getDownloadURL();
    return linksito;
  }

}