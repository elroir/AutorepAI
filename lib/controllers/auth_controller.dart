import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:ingemec/models/user_model.dart';
import 'package:ingemec/services/user_service.dart';


class AuthController extends GetxController {
  
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<FirebaseUser> _firebaseUser = Rxn<FirebaseUser>();
  
  User _usuario = new User();

  String get user => _firebaseUser.value?.email;
  User get usuario => _usuario;


  @override
  void onInit() {
    
    _firebaseUser.bindStream(_auth.onAuthStateChanged);
  }

  void createUser(String email, String password) async {
    try {
      final usuario = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print('USUARIO ID = ${usuario.user.uid}');
      _usuario = await UserService.instance.storeUsuario({
        "id_usuario" : usuario.user.uid,
        "email"      : email,
        "password"   : password,
        "tipo_usuario" : "C"
      });
      // _uid = usuario.user.uid;
    } catch (e) {
      Get.snackbar("Error al crear una cuenta", e.message, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void loginUser(String email, String password) async {
    try {
      final usuario = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('USUARIO ID = ${usuario.user.uid}');
      _usuario = await UserService.instance.getUsuario(usuario.user.uid);
      // _uid = usuario.user.uid;
    } catch (e) {
      Get.snackbar("Error al iniciar sesion", e.message, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      Get.snackbar("Error al cerrar sesion", e.message, snackPosition: SnackPosition.BOTTOM);
    }
  }

}