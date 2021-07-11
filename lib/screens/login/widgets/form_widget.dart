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

  String email;
  String password;

  final _keyForm = new GlobalKey<FormState>();

  bool   _sw    = true;
  String _error = ' ';


  @override
  Widget build(BuildContext context) {
    
    final authController = Get.put(AuthController());
    print(authController.usuario.toJson());

      return Form(
      key: _keyForm,
      child: Column(
        children: <Widget>[
          SizedBox( height: 30.0 ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              initialValue: authController.usuario.email ?? 'Ale rayos',
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
              initialValue: authController.usuario.password ?? '123',
              validator: (value) => (value.length < 6)
                  ? 'La contraseña de 6 o más caracteres'
                  : null,
              obscureText: true,
              onChanged: (value) => setState(() => password = value),
              cursorColor: Colors.white,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                labelText: 'Contraseña',
                prefixIcon: Icon(
                  Icons.security,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          BotonSubmit(
            size: 17,
            texto: (_sw) ? 'Editar Perfil' : 'Guardar',
            color: Colors.blue,
            onPress: () {}
          ),
          SizedBox(height: 10),

          BotonSubmit(
            size: 17,
            texto: 'Cerrar sesion',
            color: Colors.red[300],
            onPress: () {
              Get.put(AuthController()).signOut();
            }
          ),
          Text('$_error'),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}