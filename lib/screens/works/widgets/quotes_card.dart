import 'package:flutter/material.dart';
import 'package:ingemec/models/cotizacion_model.dart';
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
        Padding(
          padding: EdgeInsets.only(left: 10,top: 8,bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Fecha: ${this.quote.fecha.day}/${this.quote.fecha.month}/${this.quote.fecha.year}",style: Styles.titleCard,overflow: TextOverflow.clip,),
              Text("Año " + this.quote.vehiculo.modelo ?? "-",style: Styles.clientCard,overflow: TextOverflow.clip),
              Center(
                child: Container(
                  width: size.width*0.5,
                  child: Icon(Icons.directions_car_outlined,size: 96,),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Color " + this.quote.vehiculo.color ?? '-',style: Styles.clientCard,),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
