import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/user_controller.dart';
import 'package:ingemec/screens/clients/client_card.dart';

class ClientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: GetBuilder<UserController>(
        init: UserController(),
        id: 'user',
        builder: (controller) {
          if (!controller.loading){
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  SizedBox(width: double.infinity,),
                  ...controller.users.map((user) =>
                      ClientCard(user: user)).toList()
                ]
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}
