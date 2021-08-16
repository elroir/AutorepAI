import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/user_controller.dart';
import 'package:ingemec/screens/clients/client_card.dart';
import 'package:ingemec/screens/works/works_screen.dart';

class ClientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: GetBuilder<UserController>(
        init: UserController(),
        id: 'user',
        builder: (controller) {
          print(controller.loading);
          if (!controller.loading){
            final List users = controller.users.where((user) => user.tipoUsuario=='C').toList();
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:12),
                    child: TitleWithRefreshButton(
                      title: 'Clientes',
                      onPressed: controller.reload,
                    ),
                  ),
                  (Get.width>600)
                      ? this._largeScreens(controller)
                      : Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            SizedBox(width: double.infinity,),
                            ...users.map((user) =>
                                FadeInRight(duration: Duration(milliseconds: 700),child: ClientCard(user: user))).toList()
                          ]
                      )
                ] ,
              ),
            ) ;
                }
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }

Widget _largeScreens(UserController controller) {
  return GridView.builder(
    physics: BouncingScrollPhysics(),
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 350,
      crossAxisSpacing: 5,
      mainAxisExtent: 250,
      mainAxisSpacing: 5,
      childAspectRatio: 0.1

    ),
    itemCount: controller.users.length,
    itemBuilder: (_,i) {
      return ClientCard(user: controller.users[i]);

    },
  );
}
}
