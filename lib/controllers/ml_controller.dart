import 'dart:io';

import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class MLController extends GetxController{
  File image;
  ImagePicker imagePicker;
  String result;

  @override
  void onInit() {
    this.imagePicker = ImagePicker();
    result = '';
    super.onInit();
  }

  Future<void> pickImageFromGallery() async {
    PickedFile pickedFile = await this.imagePicker.getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);
      performImageLabeling();
    update(['picker']);
  }

  Future<void> pickImageFromCamera() async {
    PickedFile pickedFile = await this.imagePicker.getImage(source: ImageSource.camera);
    image = File(pickedFile.path);
    performImageLabeling();
    update(['picker']);
  }


  void performImageLabeling() async {
    final InputImage visionImage = InputImage.fromFile(image);

    final TextDetector recognizer = GoogleMlKit.vision.textDetector();

    RecognisedText visionText = await recognizer.processImage(visionImage);

    result = "";
    Pattern pattern_3 = r'^(\d{3}[a-zA-Z]{3})$';
    Pattern pattern_4 = r'^(\d{4}[a-zA-Z]{3})$';
    RegExp plate_3 = RegExp(pattern_3);
    RegExp plate_4 = RegExp(pattern_4);


    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          if( plate_3.hasMatch(element.text)||plate_4.hasMatch(element.text))
            result += element.text + ' ';
        }
      }
//      result += "\n\n";
    }

    recognizer.close();

    update(['vision']);
  }
}