
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ingemec/models/vehicle_model.dart';
import 'package:ingemec/widgets/bottom_item.dart';


class VehicleItem extends StatelessWidget {

  final Vehicle vehicle;
  final Function onPress;
  final Function onDismiss;

  const VehicleItem({Key key, this.vehicle, this.onPress, this.onDismiss}) : super(key: key);


  @override
  Widget build(BuildContext context) {
  return FadeInLeft(
      duration: Duration( milliseconds: 250 ),
      child: Dismissible(
        key : UniqueKey(),
        onDismissed: onDismiss,
        background: Container(color: Colors.red),
        child: BotonItem(
          fontSize: 16,
          texto: 'Nro Placa: ${vehicle.nroPlaca}',
          color1: Color(0xFF5898FA),
          color2: Color(0xFF5898FA),
          onPress: onPress
        ),
      ),
    );
  }
}