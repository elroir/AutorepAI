import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/screens/works/works_form.dart';
import 'package:ingemec/styles.dart';
import 'package:ingemec/widgets/main_card.dart';

class QuotesCard extends StatelessWidget {

  final Cotizacion quote;

  const QuotesCard({Key key, this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return MainCard(
      children: [
        Flexible(
          child: InkWell(
            borderRadius:BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
            onTap: () => Get.to(WorksForm(quote: this.quote)),
            child: Padding(
              padding: EdgeInsets.only(left: 10,top: 8,bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Fecha: ${this.quote.fecha.day}/${this.quote.fecha.month}/${this.quote.fecha.year}",style: Styles.titleCard,overflow: TextOverflow.clip,),
                  Expanded(
                    child: SizedBox(
                      width: size.width,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(this.quote.vehiculo.marca ?? "-",style: Styles.vehicleRedText,overflow: TextOverflow.clip),
                            Icon(Icons.directions_car_outlined,size: 64,),
                            Text(this.quote.vehiculo.modelo ?? "-",style: Styles.vehicleRedText,overflow: TextOverflow.clip,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Dias de trabajo estimados: " + this.quote.tiempoTrabajo.toString() ?? '-',style: Styles.clientCard,),
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
