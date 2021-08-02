import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ingemec/services/image_analysis_service.dart';
import 'package:ingemec/widgets/bottom_item.dart';
import 'package:ingemec/widgets/bottom_submit.dart';
import 'package:ingemec/widgets/modal_progress_indicator.dart';
import 'package:image_picker/image_picker.dart';

class ImageAnalysis extends StatefulWidget {
  @override
  _ImageAnalysisState createState() => _ImageAnalysisState();
}

class _ImageAnalysisState extends State<ImageAnalysis> {
  List<File> images = [];
  int currentFoto;

  File foto;
  String fotoUrl;
  bool _isloading;

  String descripcion = '';

  int currentIndex = 0;


  @override
  void initState() {
    _isloading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressIndicator(
        body: anadirImagenWidget(),
        texto: 'Analizando daños del vehículo...',
        color: Colors.blue[200],
        isloading: _isloading,
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
              height: 300.0,
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 1, width: double.infinity,),
          _headerAppBar(),
          SizedBox(height: 20 ),
          _mostrarFoto(),
          SizedBox(height: 20),
          BotonSubmit(
            texto: 'Añadir Imágenes',
            color: Color(0xFFCF4646),
            onPress: () => _enviarButton(),
          ),
          _multiImageList()
        ],
      ),
    );
  }

  Container _headerAppBar() {
    return Container(
      height: 50,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Análisis de Imágenes',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          IconButton(
            icon: Icon( Icons.linked_camera ),
            onPressed: () => _tomarFoto()),
          
          IconButton(
            icon: Icon( Icons.photo_library ),
            onPressed: () => _seleccionarFoto()),
        ],
      ),
    );
  }

  Container _multiImageList() {
    return Container(
      height: 200,
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
}