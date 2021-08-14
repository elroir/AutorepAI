import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/screens/cotizaciones/imports_cotizacion.dart';
import 'package:ingemec/services/images_service.dart';
import 'package:ingemec/services/storage_service.dart';

class ImageController extends GetxController{

  File currentImage;

  String _currentUrl;
  String get url => this._currentUrl;

  final TextEditingController description = TextEditingController();
  final TextEditingController date        = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> pickFromGallery() async {
    this.currentImage = await ImagesService.pickImageFromGallery();
    update(['images']);
  }

  Future<void> pickFromCamera() async {
    this.currentImage = await ImagesService.pickImageFromCamera();
    update(['images']);
  }

  Future<void> uploadPhoto() async {
    if (this.currentImage == null) return;

    print(this.currentImage.path);

    final task = StorageService.uploadFile('images/${DateTime.now()}.jpg', this.currentImage);

    if (task==null) return;

    final snapshot = await task.whenComplete(() => null);
    this._currentUrl = await snapshot.ref.getDownloadURL();
    update(['images']);

  }



}