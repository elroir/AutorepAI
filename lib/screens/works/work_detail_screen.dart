import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/follows_controller.dart';

import 'package:ingemec/controllers/works_controller.dart';
import 'package:ingemec/follows/widgets/follows_bottom_sheet.dart';
import 'package:ingemec/models/work_order_model.dart';
import 'package:ingemec/screens/cotizaciones/imports_cotizacion.dart';
import 'package:ingemec/screens/vehicles/widgets/vehicle_card.dart';
import 'package:ingemec/styles.dart';
import 'package:ingemec/utils/alerts.dart';
import 'package:ingemec/utils/date_utils.dart';
import 'package:ingemec/widgets/card_button.dart';
import 'package:ingemec/widgets/custom_text_field.dart';
import 'package:ingemec/widgets/main_card.dart';

class WorksDetail extends StatelessWidget {

  final WorkOrder order;

  WorksDetail({Key key, this.order}) : super(key: key);

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OT ${this.order.idOrden}' ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: this._formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(child: SizedBox()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Personal encargado:',style: Styles.whiteSubtitle,),
                    Text(this.order.personal.nombre,style: Styles.ubuntuTitle,),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10,bottom: 5,top: 10),
                  child: Text('Vehiculo:',style: Styles.whiteSubtitle,)
              ),
              Center(child: VehicleCard(vehicle: this.order.vehiculo,)),
              Padding(
                padding: EdgeInsets.only(left: 10,top: 10,bottom: 5),
                child: Text('Datos de la orden de trabajo:',style: Styles.whiteSubtitle,)
              ),
              CustomTextField(
                enabled: false,
                labelText: 'Fecha de ingreso',
                initialValue: '${this.order.fechaIngreso.day}/${this.order.fechaIngreso.month}/${this.order.fechaIngreso.year}',
              ),
              CustomTextField(
                labelText: 'Fecha de salida',
                inputType: TextInputType.datetime,
                initialValue: '${this.order.fechaEntrega.day}/${this.order.fechaEntrega.month}/${this.order.fechaEntrega.year}',
                onSaved: (value) {
                  final format = DateFormat('dd/MM/yyyy');
                  this.order.fechaEntrega = format.parse(value);
                },
                validator: (value) => validateDate(value),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10,top: 10,bottom: 5),
                  child: Text('Servicios:',style: Styles.whiteSubtitle,)
              ),
              ...this.order.detalles.map((detail) {
                Service service = this.order.detalleServicios.where((serv) => serv.idservicio==detail.idServicio).first;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MainCard(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    children: [
                      Flexible(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(service.nombre,style:Styles.whiteSubtitle),
                                Text(detail.observacion,style: TextStyle(color: Colors.white),maxLines: 2,overflow: TextOverflow.ellipsis,),
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Padding(
                  padding: EdgeInsets.only(left: 10,top: 10,bottom: 5),
                  child: Text('Seguimiento del vehiculo:',style: Styles.whiteSubtitle,)
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 10),
                physics: BouncingScrollPhysics(),
                child: GetBuilder<FollowController>(
                  init: FollowController(id: this.order.idOrden),
                  id: 'follows',
                  builder: (controller) {
                    if(!controller.loading){
                      return Padding(
                        padding: EdgeInsets.only(top: 3,bottom: 15),
                        child: Row(
                          children: controller.follows.map((follow) => MainCard(
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Fecha: ${dateToSpanishFormat(follow.date)}',style: Styles.titleCard,),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 5),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: Image.network(follow.imageUrl,height: 100,width: 120,fit: BoxFit.cover,)
                                        ),
                                      ),
                                      Text(follow.description)
                                    ],
                                  ),
                                ),
                              )
                            ]
                          )).toList()
                        ),
                      );
                    }
                    return SizedBox(
                      height: 200,
                      width: Get.width,
                      child: Center(child: CircularProgressIndicator.adaptive(),)
                    );
                  },
                ),
              ),
              Center(
                child: CardButton(
                  icon: FeatherIcons.edit3,
                  width: Get.width*0.9,
                  text: 'Nuevo seguimiento',
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    backgroundColor: Get.theme.cardColor,
                    builder: (_) => FollowsBottomSheet(idOrder: this.order.idOrden)

                  ) ,
                ),
              ),

              SizedBox(height: 25,),
              Center(
                child: CustomButton(
                  child: Text('Finalizar orden'),
                  onPressed: () => optionsAlert(context,
                  'Finalizar orden',
                  '¿Está seguro que desea finalizar la OT?',
                   () {
                     final FormState form = _formKey.currentState;
                     if (!form.validate()){
                       Navigator.pop(context);
                       return ;
                     }
                     form.save();
                     final workController = Get.put(WorksController());
                     workController.changeOrdersState(this.order);

                      Navigator.popUntil(context, (route) => route.isFirst);
                    })
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
