
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/styles.dart';
import 'package:ingemec/widgets/main_card.dart';

class CotizacionItem extends StatelessWidget {

  final Cotizacion cotizacion;
  final Function onPressed;

  const CotizacionItem({Key key, this.cotizacion, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return MainCard(
      children: [
        Flexible(
          child: InkWell(
            borderRadius:BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
            onTap: onPressed,
            child: Padding(
              padding: EdgeInsets.only(left: 10,top: 8,bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Fecha: ${this.cotizacion.fecha.day}/${this.cotizacion.fecha.month}/${this.cotizacion.fecha.year}",style: Styles.titleCard,overflow: TextOverflow.clip,),
                  Expanded(
                    child: SizedBox(
                      width: size.width,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(this.cotizacion.vehiculo.marca ?? "-",style: Styles.vehicleRedText,overflow: TextOverflow.clip),
                            Icon(Icons.directions_car_outlined,size: 64,),
                            Text(this.cotizacion.vehiculo.modelo ?? "-",style: Styles.vehicleRedText,overflow: TextOverflow.clip,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Dias de trabajo estimados: " + this.cotizacion.tiempoTrabajo.toString() ?? '-',style: Styles.clientCard,),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(CupertinoIcons.arrow_right_circle),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
