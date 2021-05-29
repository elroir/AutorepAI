import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ingemec/routes.dart';
import 'package:ingemec/screens/home_screen.dart';

class PageGetXController extends GetxController{

  Widget _currentPage;
  int currentPageIndex;

  @override
  void onInit() {
    this._currentPage = HomeScreen();
    this.currentPageIndex = 0;
    super.onInit();
  }

  void changePage(RouteSPA page) {

    if(Get.size.width<=500)
      Get.back();

    this.currentPageIndex = page.index;
    this._currentPage = page.page;
    update(['page']);
  }

  Widget get currentPage => this._currentPage;



}