import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/vehicle_controller.dart';
import 'package:ingemec/models/user_model.dart';
import 'package:ingemec/models/vehicle_model.dart';
import 'package:ingemec/screens/vehicles/vehicle_form.dart';
import 'package:ingemec/screens/vehicles/widgets/vehicle_card.dart';
import 'package:ingemec/styles.dart';
import 'package:ingemec/widgets/card_button.dart';
import 'package:ingemec/widgets/custom_text_field.dart';


class VehicleScreen extends StatelessWidget {

  final UserModel user;

  const VehicleScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(child: const SizedBox()),
            Padding(
              padding: EdgeInsets.only(left: 12,bottom: 12),
              child: Text('Vehiculos:',
                style:  Styles.bigTitle,
              ),
            ),
            GetBuilder<VehicleController>(
              init: VehicleController(),
              id: 'vehicle',
              builder: (controller) {
                List<Vehicle> vehicles = controller.vehicles.where((vehicle) => vehicle.idUsuario == user.idusuario).toList();
                if (!controller.loading){
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      enableInfiniteScroll: false,
                      scrollPhysics: BouncingScrollPhysics()
                    ),
                      items:vehicles.map((vehicle) =>
                      FadeIn(child: VehicleCard(vehicle: vehicle,))).toList(),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text('Datos del usuario:',
                style: Styles.bigTitle,
              ),
            ),
            CustomTextField(
              controller: TextEditingController(text: user.nombre),
              icon: Icon(FeatherIcons.user,color: Colors.white,),
              enabled: false,
              labelText: 'Nombre',
            ),
            CustomTextField(
              controller: TextEditingController(text: user.email),
              icon: Icon(FeatherIcons.mail,color: Colors.white,),
              enabled: false,
              labelText: 'Correo',
            ),
            CustomTextField(
              controller: TextEditingController(text: user.telefono.toString()),
              icon: Icon(FeatherIcons.smartphone,color: Colors.white,),
              enabled: false,
              labelText: 'Telefono',
            ),
            SizedBox(height: 25,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CardButton(
                    icon: FeatherIcons.edit3,
                    text: 'Editar datos',
                    onPressed: (){},
                  ),
                  CardButton(
                    icon: Icons.directions_car_outlined,
                    text: 'Añadir vehiculo',
                    onPressed: () {
                      Get.to(() => VehicleForm(user: user,));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 25,),

          ],
        ),
      ),
    );
  }
}


