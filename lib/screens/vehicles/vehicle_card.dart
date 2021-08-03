import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:ingemec/models/vehicle_model.dart';
import 'package:ingemec/styles.dart';

class VehicleCard extends StatelessWidget {

  final Vehicle vehicle;

  const VehicleCard({Key key, this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size =  MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: size.width*0.6,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 8,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10,top: 8,bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${vehicle.marca} ${vehicle.nroPlaca}",style: Styles.titleCard,overflow: TextOverflow.clip,),
                    Text("Año " + vehicle.modelo ?? "-",style: Styles.clientCard,overflow: TextOverflow.clip),
                    Center(
                      child: Container(
                        width: size.width*0.5,
                        child: Icon(Icons.directions_car_outlined,size: 96,),
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
          ),
        ),
      ),
    );
  }
}