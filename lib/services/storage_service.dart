import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService{

  static UploadTask uploadFile(String destination, File file) {

    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    }catch(e){
      return null;
    }

  }

}