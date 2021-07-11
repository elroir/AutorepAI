
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ingemec/controllers/auth_controller.dart';
import 'package:ingemec/screens/login/widgets/form_widget.dart';
import 'package:ingemec/widgets/circle_image.dart';
import 'package:ingemec/widgets/subcajita.dart';


class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SubcajitaWidget(
              title: 'Configuración',
              subtitle: 'Mi Perfil',
              body: _infoUsuario(),
              heightBody: 130,
            ),
            formUsuario(),
          ],
        ),
      ),
    );
  }

  Column _infoUsuario() {

    final authc = Get.put(AuthController());

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 70),
          child: CircleImage(),
        ),
        Text((authc.usuario.nombre != null)? authc.usuario.nombre : 'Sin nombre', 
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 15
          )
        )
      ],
    );
  }

  Widget formUsuario(){
    return Padding(
      padding: EdgeInsets.symmetric( horizontal: 40 ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF444e60),
          borderRadius: BorderRadius.circular(15)
        ),
        height: 330,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
