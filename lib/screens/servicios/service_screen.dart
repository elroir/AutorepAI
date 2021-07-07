
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ingemec/providers/orden_trabajo_provider.dart';
import 'package:ingemec/widgets/bottom_submit.dart';
import 'package:ingemec/widgets/header_background.dart';
import 'package:ingemec/widgets/modal_progress_indicator.dart';

class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
 
  File foto;
  String fotoUrl;
  bool _isloading;

  final _keyForm = new GlobalKey<FormState>();

  String descripcion = '';

  @override
  void initState() {
    _isloading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressIndicator(
        body: anadirImagenWidget(_keyForm),
        texto: 'Analizando el nivel de prioridad...',
        color: Colors.blue[200],
        isloading: _isloading,
      ),
      //backgroundColor: Colors.blue[50]
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
              fit: BoxFit.cover,
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

    foto = File(pickedFile.path);

    if ( foto != null ) {
      print('si es distinto de null la foto omg') ;
    }

    setState(() {});
  }

  Widget anadirImagenWidget(_keyForm) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.camera_alt,
                color: Colors.black,
              ),
              onPressed: () => _tomarFoto()
            ),
            IconButton(
              icon: Icon(
                Icons.photo_library,
                color: Colors.black,
              ),
              onPressed: () => _seleccionarFoto()
            ),
          ],
        ),

          SizedBox(height: 20),
          HeaderWidgetBackground(
            bottomLeft: 15, topLeft: 15,
            bottomright: 15,topright: 15,
            color1: Colors.blueAccent,
            color2: Colors.lightBlueAccent,
            width: 300, height: 50,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Queremos detalles sobre tu situación',
                 style: TextStyle(color: Colors.white,),
                ),
              )
            ),
          ),
          SizedBox(height: 15,),

          _mostrarFoto(),
          SizedBox(height: 20),
          datosImagen(_keyForm),
        ],
      ),
    );
  }

  Widget datosImagen(_keyForm) {
    return Form(
      key: _keyForm,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              validator: (value) => value.isEmpty ? 'Agrega una descripcion' : null,
              onChanged: (value) => setState(() => descripcion = value),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Cuéntanos tu situación' ,
                prefixIcon: Icon( Icons.description),
                hintText: 'Ej.: Sin comida',
              ),
            ),
          ),


          SizedBox(height: 15),
          BotonSubmit(
            texto: 'Añadir solicitud',
            color: Colors.greenAccent,
            onPress: () => _enviarButton(),
          )
        ],
      ),
    );
  }

  _enviarButton() async {
    
    if ( _keyForm.currentState.validate() ) {

      setState(() => _isloading = !_isloading);

      OrdenTrabajoProvider ordenProvider = new OrdenTrabajoProvider();

      String imagenUrl = await ordenProvider.subirImagen(foto);

      print('esta es la url de la fotito');
      print(imagenUrl);

      String image64 = base64Encode(foto.readAsBytesSync());
      print(image64);

      Map<String, String> dato = {
        "codigo" : "123",
        "foto"   : imagenUrl
      };

       ordenProvider.storeOrden( dato );

      setState(() => _isloading = !_isloading);

    }else{
      print('falta lad descripcion');
    }
  }
}