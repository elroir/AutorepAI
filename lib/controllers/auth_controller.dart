import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:ingemec/models/user_model.dart';
import 'package:ingemec/services/user_service.dart';


class AuthController extends GetxController {
  
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<FirebaseUser> _firebaseUser = Rxn<FirebaseUser>();
  
  User _user = new User();

  String get firebaseUser => _firebaseUser.value?.email;
  User get user => _user;


  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.onAuthStateChanged);
  }

  void createUser(String email, String password) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print('USUARIO ID = ${user.user.uid}');
      _user = await UserService.instance.storeUsuario({
        "id_usuario" : user.user.uid,
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
      _user = await UserService.instance.getUser(usuario.user.uid);
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