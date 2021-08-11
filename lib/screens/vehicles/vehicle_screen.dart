import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/vehicle_controller.dart';
import 'package:ingemec/models/user_model.dart';
import 'package:ingemec/models/vehicle_model.dart';
import 'package:ingemec/screens/vehicles/vehicle_card.dart';
import 'package:ingemec/screens/vehicles/vehicle_form.dart';
import 'package:ingemec/styles.dart';
import 'package:ingemec/widgets/custom_button.dart';
import 'package:ingemec/widgets/custom_text_field.dart';


class VehicleScreen extends StatelessWidget {

  final User user;

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
                  _CustomButton(
                    icon: FeatherIcons.edit3,
                    text: 'Editar datos',
                    onPressed: (){},
                  ),
                  _CustomButton(
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

class _CustomButton extends StatelessWidget {

  final Function onPressed;
  final IconData icon;
  final String text;

  const _CustomButton({Key key, this.onPressed, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width*0.42 ,
      child: CustomButton(
        width: MediaQuery.of(context).size.width*0.42,
        onPressed: this.onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(this.icon,color: Theme.of(context).primaryColor,size: 40,),
            SizedBox(height: 10,),
            Text(this.text,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),)
          ],
        ),
      ),
    );
  }
}

