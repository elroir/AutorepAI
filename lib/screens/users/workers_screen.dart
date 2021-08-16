import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/user_controller.dart';
import 'package:ingemec/screens/clients/client_card.dart';
import 'package:ingemec/screens/works/works_screen.dart';
import 'package:ingemec/services/user_service.dart';


class WorkersScreen extends StatelessWidget {
  
  final instance = UserService.instance;
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Text('PERSONAL DISPONIBLE', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:22)
            ),
            
            Container(
              height: Get.height * 0.85,
              child: GetBuilder<UserController>(
                init: UserController(),
                id: 'user',
                builder: (controller) {
                  print(controller.loading);
                  if (!controller.loading){
                    final List users = controller.users.where((user) => user.tipoUsuario=='P').toList();
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:12),
                          child: TitleWithRefreshButton(
                            title: 'Listado',
                            onPressed: controller.reload,
                          ),
                        ),
                        (Get.width>600)
                            ? this._largeScreens(controller)
                            : SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  SizedBox(width: double.infinity,),
                                  ...users.map((user) =>
                                      FadeInRight(duration: Duration(milliseconds: 700),child: ClientCard(user: user))).toList()
                                ]
                            )
                        )
                      ] ,
                    ) ;
                        }
                  return Center(child: CircularProgressIndicator());
                },
              )
            ),
          ],
        ),
      ),
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