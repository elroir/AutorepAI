import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:ingemec/controllers/auth_controller.dart';
import 'package:ingemec/controllers/login_controller.dart';
import 'package:ingemec/screens/login/widgets/info_header.dart';
import 'package:ingemec/widgets/bottom_submit.dart';
import 'package:ingemec/widgets/header_background.dart';

// ignore: must_be_immutable
class LoginScreen extends GetWidget<AuthController> {

  final _keyForm = new GlobalKey<FormState>();

  TextEditingController _nombreController  = new TextEditingController();
  TextEditingController _emailController  = new TextEditingController();
  TextEditingController _passwdController = new TextEditingController();
  double data = 30;


  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height * 0.5; //0.6 0.55
    final width  = MediaQuery.of(context).size.width  * 0.9;

    return Scaffold(
      // backgroundColor: Colors.blueAccent,
      body: Stack(
        children: <Widget>[
          InfoHeaderLogin(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 270),
                    GetBuilder<LoginController>(
                        init: LoginController(),
                        id: 'id_sw',
                        builder: (lcontroller) {
                          return HeaderWidgetBackground(
                            bottomLeft: data,  topright: data,
                            bottomright: data, topLeft:  data,
                            color1: Color(0xFF535f9b),
                            color2: Color(0xFF535f9b),
                            
                            height: height + ((!lcontroller.sw) ? 0 : 80), 
                            width: width,
                            child: Column(
                              children: <Widget>[
                                SizedBox( height: 30 ),
                                TituloSwitch(),
                                formWidget(),
                                SizedBox(height:  20),
                              ],
                            ),
                          );
                        }
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget formWidget(){
    
    final LoginController loginController = Get.put(LoginController());

    return Form(
      key: _keyForm,
      child: Column(
        children: <Widget>[
         
          SizedBox(height: 30),
          GetBuilder<LoginController>(
              init: LoginController(),
              id: 'id_sw',
              builder: (lcontroller) =>  Column(
                children: [

                  (!lcontroller.sw)
                  ? inputsIniciar()
                  : inputsRegistrar(),

                  SizedBox(height: 10),
                  BotonSubmit(
                    size: 17,
                    texto: !lcontroller.sw ? 'Iniciar sesion' : 'Registrar',
                    color: Colors.pink,
                    onPress: () => validarInfo(lcontroller)
                  ),
                ],
              ),
          ),
         
          Text(loginController.error),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget inputsIniciar(){
    return Column(
      children : [
        SizedBox( height: 20.0 ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              controller: _emailController,
              validator: (value) => value.isEmpty ? 'Escribe tu email' : null,
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
              controller: _passwdController,
              validator: (value) => (value.length < 6)
                  ? 'La contraseña de 6 o más caracteres'
                  : null,
              obscureText: true,
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

      ]
    );
  }

  Widget inputsRegistrar(){
    return Column(
      children : [
        SizedBox( height: 20.0 ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              controller: _nombreController,
              validator: (value) => value.isEmpty ? 'Escribe tu nombre' : null,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                labelText: 'Nombre',
                prefixIcon: Icon( Icons.person, color: Colors.white,
                ),
              ),
            ),
          ),
        SizedBox( height: 20.0 ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              controller: _emailController,
              validator: (value) => value.isEmpty ? 'Escribe tu email' : null,
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
              controller: _passwdController,
              validator: (value) => (value.length < 6)
                  ? 'La contraseña de 6 o más caracteres'
                  : null,
              obscureText: true,
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

      ]
    );
  }

  void validarInfo(LoginController lcontroller) {

    if(!lcontroller.sw){
      
      if (_emailController.text != '' && _passwdController.text != '') {
                                  
        controller.loginUser(_emailController.text, _passwdController.text);
      }else{
        print('faltan datos');
        lcontroller.setError('faltan datos omg');
      }

    }else{
      
      if (_emailController.text != '' && _passwdController.text != '' && _nombreController.text != '') {
      
        controller.createUser(_emailController.text, _passwdController.text, _nombreController.text);
      }else{
        print('Faltan datos2');
        lcontroller.setError('faltan datos omg2');
      }
    }
  }
}


class TituloSwitch extends StatelessWidget {
  
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
  
    return Expanded(
      child: Stack(
        children: <Widget>[
          FlutterSwitch(
            height: 50.0,
            width: 180.0,
            padding: 4.0,
            toggleSize: 25.0,
            borderRadius: 60.0,
            activeColor: Colors.black54,
            value: !loginController.sw,
            onToggle: (value) {
              loginController.toggle();
              loginController.setError(' ');
            },
          ),

          GetBuilder<LoginController>(
            init: LoginController(),
            id: 'id_sw',
            builder: (lcontroller) =>  Positioned(
              top: 13, left : (!lcontroller.sw) ? 24 : 50,
              child: Text(
                (!lcontroller.sw) ? 'Iniciar Sesión' : 'Registrar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color:Colors.white),
              )
            )
          ),
        ],
      ),
    );
  }
}
