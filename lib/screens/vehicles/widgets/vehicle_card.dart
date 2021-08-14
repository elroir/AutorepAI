import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ingemec/models/vehicle_model.dart';
import 'package:ingemec/styles.dart';
import 'package:ingemec/widgets/main_card.dart';

class VehicleCard extends StatelessWidget {

  final Vehicle vehicle;

  const VehicleCard({Key key, this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size =  MediaQuery.of(context).size;

    return MainCard(
      width: size.width*0.6,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10,top: 8,bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${vehicle.marca} ${vehicle.nroPlaca}",style: Styles.titleCard,overflow: TextOverflow.clip,),
              Text("Año " + vehicle.modelo ?? "-",style: Styles.clientCard,overflow: TextOverflow.clip),
              Container(
                width: size.width*0.5,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: (vehicle.urlImagen!=null) ? Image.network(vehicle.urlImagen,height: 100,fit: BoxFit.cover,) : Icon(Icons.directions_car_outlined,size: 64,),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Color " + vehicle.color ?? '-',style: Styles.clientCard,),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
