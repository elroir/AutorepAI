import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ingemec/screens/home_screen.dart';

class PageGetXController extends GetxController{

  Widget _currentPage;

  @override
  void onInit() {
    this._currentPage = HomeScreen();
    super.onInit();
  }

  set currentPage(Widget page) {
    this._currentPage = page;
    update(['page']);
  }

  Widget get currentPage => this._currentPage;



}