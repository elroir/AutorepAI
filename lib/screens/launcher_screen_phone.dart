import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:ingemec/controllers/page_controller.dart';
import 'package:ingemec/widgets/menu.dart';

class LauncherScreenPhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar() ,
      drawer:Container(
        width: 140,
        child: Drawer(
          child: Menu()
        ),
      ),
      body: GetBuilder<PageGetXController>(
          init: PageGetXController(),
          id: 'page',
          builder: (controller) => controller.currentPage
      ),
    );
  }
}
