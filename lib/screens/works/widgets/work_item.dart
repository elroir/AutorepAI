import 'package:flutter/material.dart';
import 'package:ingemec/models/work_order_model.dart';
import 'package:ingemec/styles.dart';

class WorkItem extends StatelessWidget {

  final Function onTap;
  final WorkOrder order;

  const WorkItem({Key key,@required this.onTap, this.order}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GestureDetector(
        onTap: this.onTap,
        child: Container(
          height: 200,
          width: 220,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Orden nro: ${order.idOrden}',style: TextStyle(fontWeight: FontWeight.w300),),
              Text('Ingreso: ${order.fechaIngreso.day}/${order.fechaIngreso.month}/${order.fechaIngreso.year}' ?? '-',style: Styles.cardData,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.directions_car_outlined,size: 64,),
                    Text(order.vehiculo.nroPlaca,style: Styles.cardData,),
                    Text('${order.vehiculo.marca} ${order.vehiculo.modelo}',maxLines: 2,overflow: TextOverflow.ellipsis,style: Styles.cardData,textAlign: TextAlign.center,),
                  ],
                ),
              ),

              Text('Encargado: ${order.personal.nombre}', style: TextStyle(fontWeight: FontWeight.w300)),
            ],

          ),
        ),
      ) ,
    );
  }
}
