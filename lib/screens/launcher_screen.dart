import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/page_controller.dart';
import 'package:ingemec/widgets/menu.dart';

class LauncherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 140,
            color: Theme.of(context).primaryColorDark,
            child: SafeArea(child: Menu())
          ),
          Expanded(
            child: SafeArea(
              child: GetBuilder<PageGetXController>(
                init: PageGetXController(),
                id: 'page',
                builder: (controller) => controller.currentPage
              ),
            ),
          )

        ],
      ),
    );
  }
}

