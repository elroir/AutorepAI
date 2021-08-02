import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/service_controller.dart';
import 'package:ingemec/models/service_model.dart';
import 'package:ingemec/screens/images_analysis/images_analysis_screen.dart';
import 'package:ingemec/screens/services/create_service_screen.dart';
import 'package:ingemec/widgets/bottom_item.dart';
import 'package:ingemec/widgets/bottom_submit.dart';

// ignore: must_be_immutable
class CreateCotizacionScreen extends StatefulWidget {
  
  @override
  _CreateCotizacionScreenState createState() => _CreateCotizacionScreenState();
}

class _CreateCotizacionScreenState extends State<CreateCotizacionScreen> {
  TextEditingController observacionController = new TextEditingController();

  TextEditingController tiempoTrabajoController = new TextEditingController();

  TextEditingController fechaController = new TextEditingController();

  TextEditingController personalIdController = new TextEditingController();

  TextEditingController vehiculoIdController = new TextEditingController();

  List<int> serviciosId = [];

  int currentI = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Text('REGISTRAR COTIZACION', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:22)
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: ColorBoxDecoration(
                color: Color(0xff535f9b),
                height: Get.height * 0.73,
                // height: Get.height * 0.8,
                //height: 325,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      _escogerWidget(),
                      SizedBox(height: 8),
                      // SizedBox(height: 8),

                      // SizedBox(height: 8),
                      // _createCotizacionForm(),
                      
                      // SizedBox(height: 15),
                      // _serviciosListC(),
                      // SizedBox(height: 15),
                      // BotonSubmit(                        
                      //   color: Color(0xFFdb6060), 
                      //   texto: "Crear", 
                      //   onPress: (){}
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavBar(),
    );
    
  }
  
  // ignore: missing_return
  Widget _escogerWidget(){
    
    switch (currentI) {
      case 0 : return _vehiculosListC();
      case 1 : return Container();
      case 2 : return _createCotizacionForm();
      case 3 : return _serviciosListC();
      case 4 : return
        BotonSubmit(                        
          color: Color(0xFFdb6060), 
          texto: "Crear", 
          onPress: (){}
        );
      // case 3 : return _vehiculosListC();
    }
  }

  Widget _bottomNavBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      currentIndex: currentI,
      backgroundColor: Color(0xff445CBD),
      onTap: (value) => setState(() => currentI = value),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.car_repair),
          title: Text('Vehiculo'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dangerous),
          title: Text('Daño'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.addchart),
          title: Text('Cotizacion'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          // icon: Icon(Icons.settings,color: Colors.white),
          title: Text('Servicios'),
          // title: Text('Servicios', style: TextStyle(color: Colors.white)),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle_outline),
          title: Text('Confirmar')
        ),
      ],
    );
  }

  Widget _serviciosListC() {
    return   Container(
      height: Get.height * 0.7,
      // height: Get.height * 0.33,
      child:  GetBuilder<ServiceController>(
      init: ServiceController(),
      id: 'listaservicios',
      builder: (lcontroller) => ListView.builder(
              physics: BouncingScrollPhysics(),
        itemCount: lcontroller.servicios.length ,
        itemBuilder:(_, index) {
          Service item = lcontroller.servicios[index];
          return _serviceItem(item);
        },
      )
      ),
    );
  }

   FadeInLeft _serviceItem(Service item) {
    return FadeInLeft(
      duration: Duration( milliseconds: 250 ),
      child: Dismissible(
        key : UniqueKey(),
        onDismissed: (direction) async {
          print('bye');
        },
        background: Container(color: Colors.red),
        child: BotonItem(
          texto: item.nombre,
          color1: Color(0xFF535f9b),
          color2: Color(0xFF535f9b),
          onPress: () {
            setState((){
              serviciosId.add(item.idservicio);
              print("lista length =  ${serviciosId.length}");
            });
            // Get.to(() => EditServiceScreen( item ));
          },
        ),
      ),
    );
  }


  Form _createCotizacionForm() {
    return Form(
        child: Column(
          children: [
            // SizedBox( height: 30.0 ),
            // Checkbox(value: false, onChanged: (val){}),
            TextFormField(
              controller: observacionController,
              validator: (value) => value.isEmpty ? 'Observacion' : null,
              cursorColor: Colors.white,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                labelText: 'Observacion',
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                hintText: 'Arreglar ... ',
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: tiempoTrabajoController,
              validator: (value) => value.isEmpty ? 'Tiempo de trabajo (dias)' : null,
              cursorColor: Colors.white,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                labelText: 'Tiempo de trabajo (dias)',
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                hintText: '10 dias ',
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: vehiculoIdController,
              validator: (value) => value.isEmpty ? 'Vehiculo' : null,
              cursorColor: Colors.white,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                labelText: 'Vehiculo',
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                hintText: 'NISSAN - 123ABC ... ',
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              initialValue: DateTime.now().toString(),
              // controller: vehiculoIdController,
              validator: (value) => value.isEmpty ? 'Fecha' : null,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                labelText: 'Fecha',
                prefixIcon: Icon(Icons.person, color: Colors.white),
                hintText: '2021-08-12 ',
              ),
            ),
          ],
        )
      );
  }

  Widget _vehiculosListC() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Text('Seleccionar un vehículo', style: TextStyle(fontSize: 18),),
        ),
        Container(
          height: Get.height * 0.25,
          child: SingleChildScrollView(
            child:Column(
              children: [
                _serviceItem2(),
                _serviceItem2(),
                _serviceItem2(),
                _serviceItem2(),
              ],
            )
          ),
        ),
      ],
    );
  }

  FadeInLeft _serviceItem2() {
    return FadeInLeft(
      duration: Duration( milliseconds: 250 ),
      child: Dismissible(
        key : UniqueKey(),
        onDismissed: (direction) async {
          print('bye');
        },
        background: Container(color: Colors.red),
        child: BotonItem(
          texto: 'item.nombre',
          color1: Color(0xFFDF576C),
          color2: Color(0xFFDF576C),
          onPress: () {
            
            // Get.to(() => EditServiceScreen( item ));
          },
        ),
      ),
    );
  }



}