import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/screens/cotizaciones/imports_cotizacion.dart';
import 'package:ingemec/widgets/custom_text_field.dart';
import 'package:ingemec/widgets/generalAppBar.dart';

class NuevaCotizacionScreen extends StatefulWidget {

  @override
  _NuevaCotizacionScreenState createState() => _NuevaCotizacionScreenState();
}

class _NuevaCotizacionScreenState extends State<NuevaCotizacionScreen> {
  
  final vehiculoController = new TextEditingController();

  TextEditingController observacionController = new TextEditingController();
  TextEditingController tiempoTrabajoController = new TextEditingController();
  TextEditingController fechaController = new TextEditingController();

  final style = TextStyle(color: Colors.white, fontSize: 18, fontWeight:FontWeight.bold);

  List<Service> serviciosI = [];
  //Para daño
  List<File> images = [];
  int currentFoto;
  File foto;
  String fotoUrl;
  bool _isloading;
  String descripcion = '';
  int currentIndex = 0;

  //Grado
  GradoDanio gradoDanio = new GradoDanio();
  double gradoValor = -1;

  //Precio total
  double precioTotal = 0;

  int idVehiculo = 0;


  @override
  void initState() {
    _isloading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarG(),
      body: Column(
        children: [
          Text('REGISTRAR COTIZACION', 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize:22)
          ),
          SizedBox(height: 20),
          Expanded(child: _cotizacionForm(context)),
        ],
      ),
      floatingActionButton: (foto != null)
        ? FadeInRight(
          child: FloatingActionButton(
            child: Icon(Icons.crop),
            onPressed: () =>  recortarImagen(),
          ),
        )
        : Container(),
    );
  }

  Form _cotizacionForm(BuildContext context) {
    return Form(
      child: Container(
        height: Get.height * 0.8,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Seleccionar Vehiculo: ', style: style),
              GestureDetector(
                  onTap: () => showModalBottomSheet(
                    backgroundColor: Theme.of(context).cardColor,
                    context: context,
                    builder: (_) {
                      return GetBuilder<VehicleController>(
                        id: 'vehicle',
                        init: VehicleController(),
                        builder: (controller){
                          if(!controller.loading){
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: controller.vehicles.length,
                              itemBuilder: (_,i) => ListTile(
                                onTap: () {
                                  // vehiculoController.text = controller.vehicles[i].idVehiculo.toString();
                                  idVehiculo = controller.vehicles[i].idVehiculo;
                                  vehiculoController.text = controller.vehicles[i].nroPlaca;
                                  Get.back();
                                },
                                title: Text(controller.vehicles[i].nroPlaca,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
                              )
                            );
                          }
                          return SizedBox();
                        }

                      );
                    }
                  ),
                  child: CustomTextField(
                    controller: this.vehiculoController ,
                    labelText: 'Nro de Placa',
                    enabled: false,
                    validator: (value) {
                      if(value.isNotEmpty)
                        return null;
                      return 'Campo obligatorio';
                    },
                  ),
                ),
              SizedBox(height: 15),
              _daniosPage(),
              SizedBox(height: 15),
              _cotizacionFormPage(),
              SizedBox(height: 25),
              _serviciosPage(),
              SizedBox(height: 15),
              _confirmPage(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

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
        Text('Fotografías de Daño', style: style),
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
            width: 110, borde: 50, height :20,
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

      setState(() {
        gradoDanio.nombre = resp2;
        gradoValor =  double.tryParse(resp2);
      });


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

  //para el form

  Widget _cotizacionFormPage() {
    
    return CotizacionForm(
      observacionController: observacionController,
      tiempoTrabajoController:tiempoTrabajoController,
      fechaController: fechaController,
      // gradoDanio: gradoDanio,
      textStyle: style,
      child: Padding(
        padding: EdgeInsets.symmetric( horizontal : 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColorDark
          ),
          height: 50,
          child: Padding(
            padding:  EdgeInsets.symmetric( horizontal : 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.person, color: Colors.white),
                SizedBox(width: 12),
                Text('Grado de daño (Porcentaje) : ${gradoValor * 100} %'),
              ],
            ),
          ),
        ),
      ),
      // child: CustomTextField(
      //   // initialValue: (gradoDanio.nombre != null) ? '${double.parse(gradoDanio.nombre) * 100} %' : 'lol',
      //   // initialValue: (gradoValor >= 0) ? '${gradoValor * 100} %' : '-',
      //   initialValue: (gradoValor > -1) ? '$gradoValor' : '-',
      //   validator: (value) => value.isEmpty ? 'Grado!' : null,
      //   labelText: 'Grado de Daño - Porcentaje',
      //   icon: Icon(Icons.person, color: Colors.white),
      // ),
    );
  }


  //para servicios

  Widget _serviciosPage() {
    return   Column(
      children: [
        Text('Seleccionar los servicios que requiera:' , style: style),
        SizedBox( height: 20),
        Container(
          height: Get.height * 0.4,
          child:  GetBuilder<ServiceController>(
            init: ServiceController(),
            id: 'listaservicios',
            builder: (lcontroller) => ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: lcontroller.servicios.length ,
              itemBuilder:(_, index) {

                Service item = lcontroller.servicios[index];
                return ServicioPrecioItem(
                  item: item,
                  // gradoDropdown: _gradoDropdown(),
                  onPress:() {
                    setState((){
                      serviciosI.add(item);
                      print("lista2 length =  ${serviciosI.length}");
                    });
                  }
                );
              },
            )
          ),
        ),
      ],
    );
  }
  
  
  //pagina para confirmar
  Widget _confirmPage() {
    return Container(
      width: Get.width,
      child: Column(
        children: [
          Center( child: Text( '¿Confirma todos los datos registrados?', style: style ) ), 
          SizedBox(height: 15),
          CustomButton(
            onPressed:_calcularPrecio,
            width: Get.width*0.5,
            child: Text( 'Total:   Bs. $precioTotal',)
          ),        
          SizedBox(height: 20),
           BotonSubmit(                        
            color: Color(0xFFdb6060), 
            texto: "Registrar Cotizacion", 
            onPress: () async {
             
              List<Map<String, dynamic>> servicioss = [];

                for (var item in serviciosI) {

                  Map<String, dynamic> servicio = {
                    "id"           : item.idservicio,
                    "precio_venta" : item.precio, // * el umbral puede ser lol, aunque creo que eso lo hago en el back
                    "descripcion"  : 'Ninguna',
                    // "umbral"       : double.tryParse( gradoDanio.nombre)
                    "umbral"       : gradoValor
                  };
                  print(servicio);
                  print('======');
                  servicioss.add(servicio);
              } 

              var sCoti = Get.put(QuotesController());

              final sw = false;
              // final sw = await sCoti.storeCotizacion(
              //   obs: observacionController.value.text,
              //   fecha: new DateFormat("yyyy-MM-dd").format(DateTime.now()),
              //   tiempodias: tiempoTrabajoController.value.text,
              //   idvehiculo: (idVehiculo > 0) ? idVehiculo : 20, //idk
              //   // idvehiculo: int.tryParse( vehiculoController.value.text ) ?? 1, //idk
              //   // umbral: double.tryParse( gradoDanio.nombre), //idk
              //   servicioss: servicioss
              // );
                // servicios: serviciosI
              if (sw) {
                Get.back();
              }else{
                print('rayos no se pudo');
              }
            }
          )
        ],
      ),
    );
  }
  void _calcularPrecio(){
    this.precioTotal = 0;
    for (var item in serviciosI) {
      this.precioTotal += item.precio;
    }
    setState(() {});
  }

}