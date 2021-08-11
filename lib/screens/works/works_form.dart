import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/user_controller.dart';
import 'package:ingemec/models/cotizacion_model.dart';
import 'package:ingemec/models/work_order_model.dart';
import 'package:ingemec/screens/cotizaciones/imports_cotizacion.dart';
import 'package:ingemec/services/works_service.dart';
import 'package:ingemec/styles.dart';
import 'package:ingemec/widgets/custom_button.dart';
import 'package:ingemec/widgets/custom_text_field.dart';
import 'package:ingemec/widgets/main_card.dart';
import 'package:intl/intl.dart';

class WorksForm extends StatelessWidget {

  final Cotizacion quote;

  WorksForm({this.quote});

  final _formKey = GlobalKey<FormState>();

  final _order = WorkOrder();

  final TextEditingController _userController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final String startDateString = '${this.quote.fecha.day}/${this.quote.fecha.month}/${this.quote.fecha.year}' ?? '-';
    final DateTime endDate = this.quote.fecha.add( Duration(days: this.quote.tiempoTrabajo) );
    final String endDateString = '${endDate.day}/${endDate.month}/${endDate.year}' ?? '-';

    this._order.servicios = List.filled(this.quote.servicios.length, Servicio(descripcion: ''));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Nueva Orden'),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: this._formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(child: Container(),),
              CustomTextField(
                labelText: 'Fehca de ingreso',
                initialValue: startDateString,
              ),
              CustomTextField(
                labelText: 'Fecha de salida',
                initialValue: endDateString,
                onSaved: (value) {
                  final format = DateFormat('dd/mm/yyyy');
                  this._order.fechaEntrega = format.parse(value);
                },
              ),
              GestureDetector(
                onTap: () => showModalBottomSheet(
                  backgroundColor: Theme.of(context).cardColor,
                  context: context,
                  builder: (_) {
                    return GetBuilder<UserController>(
                      id: 'user',
                      init: UserController(),
                      builder: (controller){
                        if(!controller.loading){
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.users.length,
                            itemBuilder: (_,i) => ListTile(
                              onTap: () {
                                this._userController.text = controller.users[i].nombre;
                                this._order.idPersonal = controller.users[i].idusuario;
                                Get.back();
                              },
                              title: Text(controller.users[i].nombre,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
                            )

                          );
                        }
                        return SizedBox();
                      }

                    );
                  }
                ),
                child: CustomTextField(
                  controller: this._userController ,
                  labelText: 'Personal encargado',
                  enabled: false,
                  validator: (value) {
                    if(value.isNotEmpty)
                      return null;
                    return 'Campo obligatorio';
                  },
                ),
              ),
              if(this.quote.servicios.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Servicios',style: Styles.bigTitle,),
                ),
              ...this.quote.servicios.map((service) {
                int i = this.quote.servicios.indexOf(service);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                  child: GestureDetector(
                    onTap: () => showModalBottomSheet(
                        backgroundColor: Theme.of(context).cardColor,
                        context: context,
                        builder: (_) {
                          final TextEditingController textController = TextEditingController(text: this._order.servicios[i].descripcion) ;
                          return SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                CustomTextField(
                                  labelText: 'Descripción',
                                  controller: textController,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25),
                                  child: CustomButton(
                                    child: Text('Guardar',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20
                                      ),
                                    ),
                                    onPressed: () {
                                      this._order.servicios[i] = Servicio(
                                          idServicio: service.idservicio,
                                          descripcion: textController.text
                                      );
                                      Get.back();
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        } ) ,
                    child: MainCard(
                      height: 50,
                      width: Get.width,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(service.nombre,style: TextStyle(color: Colors.white,),),
                                  Icon(FeatherIcons.plusCircle,color: Get.theme.primaryColor,),

                                ],
                              ),
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              ).toList(),
              SizedBox(height: 25,),
              Center(
                child: CustomButton(onPressed: this._submit,
                  child: Text('Guardar',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    );

  }

  void _submit() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) return;
    form.save();

    //Get.dialog(Center(child: CircularProgressIndicator.adaptive(),));

    this._order.idCotizacion = this.quote.idCotizacion;
    this._order.idOrden = 12;


    await WorksService.instance.newWorkOrder(this._order);
    Get.back();

  }

}
