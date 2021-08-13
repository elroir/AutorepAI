import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagesService {

  static ImagePicker imagePicker = ImagePicker();

  static Future<File> pickImageFromGallery() async {
    try{
      XFile pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
      File image = File(pickedFile.path);
      return image;
    }catch(e){
      return null;
    }

  }

  static Future<File> pickImageFromCamera() async {
    try{
      XFile pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
      File image = File(pickedFile.path);
      return image;
    }catch(e){
      return null;
    }
  }

  static Future<List<File>> pickMultipleFromGallery() async {
    try{
      List<XFile> pickedFiles = await imagePicker.pickMultiImage();
      List<File> files = [];
      pickedFiles.forEach((file) {
        files.add(File(file.path));
      });
      return files;
    }catch(e){
      return [];
    }

  }

}