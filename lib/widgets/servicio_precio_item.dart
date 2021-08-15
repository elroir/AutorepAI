import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ingemec/models/service_model.dart';

import 'bottom_item.dart';

// ignore: must_be_immutable
class ServicioPrecioItem extends StatelessWidget {
  
  final Service item;
  final Function onPress;
  final Widget gradoDropdown;

  const ServicioPrecioItem({this.item, this.onPress, this.gradoDropdown});


  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: Duration( milliseconds: 250 ),
      child: Dismissible(
        key : UniqueKey(),
        onDismissed: (direction) async {
          print('bye');
        },
        background: Container(color: Colors.red),
        child: BotonItem(
          imgW:Padding(
            padding: EdgeInsets.only(left: 6),
            child: gradoDropdown,
          ),
         
          iconW: _precio(item),
          fontSize: 12,
          texto: '${item.nombre}',
          color1: Color(0xFF535f9b),
          color2: Color(0xFF535f9b),
          // color1: Color(0xFF535f9b),
          // color2: Color(0xFF535f9b),
          onPress: onPress,
        ),
      ),
    );
  }

  Widget _precio(Service item) {
    return Container(
    height: 45, width: 45,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(50)
    ),
    child: Center(
      child: Text('Bs. ${item.precio.toString()}', 
        style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)
      )
    ),
  );
  }
}