import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ingemec/controllers/auth_controller.dart';

import 'package:ingemec/controllers/service_controller.dart';
import 'package:ingemec/controllers/vehicle_controller.dart';
import 'package:ingemec/models/grado_danio_model.dart';
import 'package:ingemec/models/service_model.dart';
import 'package:ingemec/models/vehicle_model.dart';
import 'package:ingemec/screens/services/create_service_screen.dart';
import 'package:ingemec/services/image_analysis_service.dart';
import 'package:ingemec/widgets/bottom_item.dart';
import 'package:ingemec/widgets/bottom_submit.dart';
import 'package:ingemec/widgets/custom_button.dart';
import 'package:ingemec/widgets/generalAppBar.dart';
import 'package:ingemec/widgets/modal_progress_indicator.dart';

// ignore: must_be_immutable
class CreateCotizacionScreen extends StatefulWidget {
  
  @override
  _CreateCotizacionScreenState createState() => _CreateCotizacionScreenState();
}

class _CreateCotizacionScreenState extends State<CreateCotizacionScreen> {
  
  TextEditingController observacionController = new TextEditingController();
  TextEditingController tiempoTrabajoController = new TextEditingController();
  TextEditingController fechaController = new TextEditingController();

  List<int> serviciosId = [];
  List<Service> serviciosI = [];

  int currentI = 0;

  //Para daño
  List<File> images = [];
  int currentFoto;
  File foto;
  String fotoUrl;
  bool _isloading;
  String descripcion = '';
  int currentIndex = 0;

  //Grado
  GradoDanio gradoDanio;

  //Precio total
  double precioTotal = 0;

  //Id vehiculo
  int vehiculoId;

  String _chosenValue;

  TextStyle _titleStyle =  TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  void initState() {
    _isloading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarG(),
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      _escogerWidget(),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavBar(),
       floatingActionButton: (currentI == 1 && foto != null)
        ? FadeInRight(
          child: FloatingActionButton(
            child: Icon(Icons.crop),
            onPressed: () =>  recortarImagen(),
          ),
        )
        : Container(),
    );
    
  }
  
  // ignore: missing_return
  Widget _escogerWidget(){
    
    switch (currentI) {
      case 0 : return _vehiculosPage();
      case 1 : return _daniosPage();
      case 2 : return _cotizacionFormPage();
      case 3 : return _serviciosPage();
      case 4 : return _confirmPage();
       
    }
  }

  Widget _bottomNavBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      currentIndex: currentI,
      backgroundColor: Color(0xff445CBD),
      onTap: (value) => setState(() => currentI = value),
      items: <BottomNavigationBarItem> [
       
        BottomNavigationBarItem( icon: Icon(Icons.car_rental), label: 'Vehiculo' ),
        BottomNavigationBarItem( icon: Icon(Icons.dangerous), label: 'Daño' ),
        BottomNavigationBarItem( icon: Icon(Icons.addchart), label: 'Cotizacion' ),
        BottomNavigationBarItem( icon: Icon(Icons.settings), label: 'Servicios' ),
        BottomNavigationBarItem( icon: IconButton(icon: Icon(Icons.check_circle_outline), onPressed: _calcularPrecio,), label: 'Confirmar' )
      ],
    );
  }

  void _calcularPrecio(){
    this.precioTotal = 0;
    for (var item in serviciosI) {
      this.precioTotal += item.precio;
    }
    setState(() {});
  }


  Widget _vehiculosPage() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Text('Seleccionar un vehículo:', style: _titleStyle),
        ),
        Container(
          height: Get.height * 0.6,
           child:  GetBuilder<VehicleController>(
            init: VehicleController(),
            id: 'vehicle',
            builder: (vcontroller) => ListView.builder(
                    physics: BouncingScrollPhysics(),
              itemCount: vcontroller.vehicles.length ,
              itemBuilder:(_, index) {
                Vehicle item = vcontroller.vehicles[index];
                return _vehicleItem(item);
              },
            )
          ),
        ),
      ],
    );
  }

  
  FadeInLeft _vehicleItem(Vehicle vehicle) {
    return FadeInLeft(
      duration: Duration( milliseconds: 250 ),
      child: Dismissible(
        key : UniqueKey(),
        onDismissed: (direction) async {
          print('bye');
        },
        background: Container(color: Colors.red),
        child: BotonItem(
          fontSize: 16,
          texto: 'Nro Placa: ${vehicle.nroPlaca}',
          color1: Color(0xFF5898FA),
          color2: Color(0xFF5898FA),
          onPress: () => setState(() => vehiculoId = vehicle.idVehiculo ),
        ),
      ),
    );
  }


  //Para daño

  Widget _daniosPage() {
    return Container(
      width: Get.width,
      child: ModalProgressIndicator(
        body: anadirImagenWidget(),
        texto: 'Analizando daños del vehículo...',
        color: Colors.blue[200],
        isloading: _isloading,
      )
    );
  }


  Widget _mostrarFoto() {

    if (fotoUrl != null) {
      //TOdo tengo que hacer esto
      return Container();
    } else {
      return Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: (foto != null) 
            ? Image.file(
              foto,
              //fit: BoxFit.cover,
              height: 250.0,
            )
            : Image.asset('assets/no-image.png'),
          ),
        ),
      ); 
    }
  }

  _seleccionarFoto() async => await _procesarImagen(ImageSource.gallery);
  _tomarFoto() async => await _procesarImagen(ImageSource.camera);

  _procesarImagen(ImageSource origen) async {
  
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(source: origen);

    if(pickedFile != null){

      foto = File(pickedFile.path);
      
      if ( foto != null ) {
        print('si es distinto de null la foto omg') ;
        images.add(foto);
        currentFoto = images.length-1;//creo
        //recortarImagen();  
      }

      setState(() {});
    }else{
      print('============No tome ninguna foto==========');
    }

  }

  Widget anadirImagenWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 1, width: double.infinity,),
         Text(
          'Análisis de Imágenes',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 20 ),
        _botones(),
        SizedBox(height: 20 ),
        _body(),
       
      ],
    );
  }

  Widget _body(){
    return Container(
      height: Get.height * 0.48,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _mostrarFoto(),
            SizedBox(height: 10),
            _multiImageList()
          ],
        ),
      ),
    );
  }

  Widget _botones(){
    return Container(
      height: 50,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButton(
            onPressed: () => _tomarFoto(),
            width: Get.width*0.15,
            child: Icon(FeatherIcons.camera)
          ),
          CustomButton(
            onPressed: () => _seleccionarFoto(),
            width: Get.width*0.15,
            child: Icon(FeatherIcons.image)
          ),
        
          BotonSubmit(
            width: 110, borde: 20,
            texto: 'Analizar daños',
            color: Color(0xFFCF4646),
            onPress: () => _enviarButton(),
          ),
        ],
      ),
    );
  }

  Container _multiImageList() {
    return Container(
      height: 110,
      child: ListView.builder(
        itemCount: images.length,
        itemBuilder:(_, index){
          return Dismissible(
            key : UniqueKey(),
            onDismissed: (direction) async {
              print('bye');
              setState(() {
                
                images.removeAt(index);
                print('length ${images.length}');
              });
            },
            background: Container(color: Colors.red),
            child: _imageItemList(index)
          );
        }
      ),
    );
  }

  Widget _imageItemList(int index) { //container
    return BotonImageItem(
      foto: images[index],
      onPress:(){
        //cambio la foto para editar esa no?
        setState(() {
          foto = images[index];
          currentFoto = index;
        });
        _mostrarFoto();
      } ,
      texto: "Imagen ${index + 1}",
      color1: Color(0xFF468FCF),
      color2: Color(0xFF468FCF),
    );
  }

 

  _enviarButton() async {
    
    if ( foto.path != null ) {

      final imageAnalysis = ImageAnalysisService.instance;

      setState(() => _isloading = !_isloading);
      
      String image64 = base64Encode(foto.readAsBytesSync());

      final resp = await imageAnalysis.subirImagen(images[0]);

      print('URL DE IMAGEN = $resp');

      final resp2 = await imageAnalysis.analizarDanio({
        "url_imagen" : resp
      });
      
      print('SCORE IMAGEN = $resp2');

      //navegar a la otra pantalla
      setState(() => _isloading = !_isloading);

      Get.snackbar("OK", resp2);

    }else{
      print('falta lad descripcion');
    }
  }
 
  Future<Null> recortarImagen() async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: foto.path,
      aspectRatioPresets: Platform.isAndroid
        ? [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ]
        : [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio16x9
          ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Recortar fotografía',
        toolbarColor: Colors.blueAccent,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        title: 'Recortar',
      )
    );
    if (croppedFile != null) {
      setState(() {
        foto = croppedFile;
        images[currentFoto] = foto; //creo x2
      } );
    }
  }
  
  Widget _cotizacionFormPage() {
    return Padding(
      padding: EdgeInsets.symmetric( horizontal: 17 ),
      child: Form(
          child: Column(
            children: [
              Text('Datos de la proforma', style: _titleStyle),
              SizedBox(height: 15),

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
              SizedBox(height: 8),

              TextFormField(
                initialValue: (gradoDanio != null) ? gradoDanio.nombre : 'lol',
                validator: (value) => value.isEmpty ? 'Grado!' : null,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  labelText: 'Grado de Daño',
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ],
          )
        ),
    );
  }


  Widget _serviciosPage() {
    return   Column(
      children: [
        Text('Seleccionar los servicios que requiera:' , style: _titleStyle,),
        SizedBox( height: 20),
        Container(
          height: Get.height * 0.7,
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
        ),
      ],
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
          imgW:Padding(
            padding: EdgeInsets.only(left: 6),
            child: _gradoDropdown(),
          ),
         
          iconW: _servicioPrecio(item),
          fontSize: 12,
          texto: '${item.nombre}',
          color1: Color(0xFF535f9b),
          color2: Color(0xFF535f9b),
          onPress: () {
            setState((){
              serviciosId.add(item.idservicio);
              serviciosI.add(item);
              print("lista length =  ${serviciosId.length}");
              print("lista2 length =  ${serviciosI.length}");
            });
            // Get.to(() => EditServiceScreen( item ));
          },
        ),
      ),
    );
  }

   Widget _servicioPrecio(Service item) {
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

  Widget _confirmPage() {
    return Container(
      width: Get.width,
      child: Column(
        children: [
          Center(
            child: 
            Text( '¿Confirma todos los datos registrados?', 
              style: _titleStyle
            )
          ), 
          SizedBox(height: 15),
          CustomButton(
            onPressed: () {},
            width: Get.width*0.5,
            child: Text( 'Total:   Bs. $precioTotal',)
          ),        
          SizedBox(height: 20),
           BotonSubmit(                        
            color: Color(0xFFdb6060), 
            texto: "Registrar Cotizacion", 
            onPress: (){
              //TODO: llamar al método storeCotizacion
              print('registrando cotizacion y detalles...');
              print('observacion: ${observacionController.value}');
              print('fecha: ${DateTime.now()}'); //dara error
              print('tiempo_trabajo : ${tiempoTrabajoController.value}');
              print('id_vehiculo : $vehiculoId');
              print('id_personal: ${Get.find<AuthController>().user.idusuario}'); //creo
              print('');
              

            }
          )
        ],
      ),
    );
  }

  Widget _gradoDropdown() {
    return Container(
      width: Get.width * 0.18,
      decoration: BoxDecoration(
        color: Color(0xff4583DF),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric( horizontal: 8.0),
        child: DropdownButton<String>(
          value: _chosenValue,
          //elevation: 5,
          style: TextStyle(color: Colors.black),

          items: <String>[
            'FUERTE',
            'MEDIO',
            'LEVE',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(color: Colors.white, fontSize: 9)),
            );
          }).toList(),
          hint: Text("Daño"),
          onChanged: (String value) {
            setState(() {
              _chosenValue = value;
            });
          },
        ),
      ),
    );
  }



}