import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/auth_controller.dart';
import 'package:ingemec/widgets/bottom_submit.dart';

class FormWidget extends StatefulWidget {
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {

  double data = 30;

  String nombre;
  String email;
  String password;

  final _keyForm = new GlobalKey<FormState>();

  bool   _sw    = true;
  String _error = ' ';


  @override
  Widget build(BuildContext context) {
    
    final authController = Get.put(AuthController());
    print(authController.user.toJson());

      return Form(
      key: _keyForm,
      child: Column(
        children: <Widget>[
          SizedBox( height: 30.0 ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              initialValue: ( authController.user.nombre != null )
                            ? authController.user.nombre : "Cliente1",
              validator: (value) => value.isEmpty ? 'Nombre' : null,
              onChanged: (value) => setState(() => nombre = value),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                labelText: 'Nombre',
                prefixIcon: Icon( Icons.person, color: Colors.white),
              ),
            ),
          ),
          SizedBox( height: 10.0 ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              initialValue: authController.getEmail(),
              validator: (value) => value.isEmpty ? 'Escribe tu email' : null,
              onChanged: (value) => setState(() => email = value),
              cursorColor: Colors.white,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                labelText: 'Email',
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                hintText: 'ale@gmail.com',
              ),
            ),
          ),
          SizedBox( height: 20.0 ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              initialValue: authController.getPassword(),
              validator: (value) => (value.length < 6)
                  ? 'La contrase??a de 6 o m??s caracteres'
                  : null,
              obscureText: true,
              onChanged: (value) => setState(() => password = value),
              cursorColor: Colors.white,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                labelText: 'Contrase??a',
                prefixIcon: Icon(
                  Icons.security,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            height: 50,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BotonSubmit(
                    width: 100,
                    size: 17,
                    texto: (_sw) ? 'Editar Perfil' : 'Guardar',
                    color: Colors.blue,
                    onPress: () async {
                      

                    }
                  ),
                  SizedBox(height: 10),

                  BotonSubmit(
                     width: 120,
                    size: 17,
                    texto: 'Cerrar sesion',
                    color: Colors.red[300],
                    onPress: () {
                      Get.put(AuthController()).signOut();
                    }
                  ),
                ],
              ),
            ),
          ),
          
          Text('$_error'),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}