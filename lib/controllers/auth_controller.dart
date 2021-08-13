import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:ingemec/models/user_model.dart';
import 'package:ingemec/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthController extends GetxController {
  
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<FirebaseUser> _firebaseUser = Rxn<FirebaseUser>();

  SharedPreferences _prefs;
  SharedPreferences get prefs => this._prefs;

  String get userId => this._prefs.getString('uid') ?? '';

  User _user = new User();

  String get firebaseUser => _firebaseUser.value?.email;
  User get user => _user;


  @override
  void onInit() {
    super.onInit();
    this.initPrefs();
    _firebaseUser.bindStream(_auth.onAuthStateChanged);
  }

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  String getEmail()  {
    return this._prefs.getString('email') ?? '';
  }

  String getPassword() {
    return this._prefs.getString('password') ?? '';
  }

  void createUser(String email, String password) async {


    try {
      this._prefs.setString('email', email);
      this._prefs.setString('password', password);
      final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print('USUARIO ID = ${user.user.uid}');
      this._prefs.setString('uid', user.user.uid);

      _user = await UserService.instance.storeUsuario({
        "id_usuario" : user.user.uid,
        "email"      : email,
        "password"   : password,
        "tipo_usuario" : "P"
      });

      // _uid = usuario.user.uid;
    } catch (e) {
      Get.snackbar("Error al crear una cuenta", e.message, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void loginUser(String email, String password) async {
    try {
      this._prefs.setString('email', email);
      this._prefs.setString('password', password);
      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      this._prefs.setString('uid', user.user.uid);

      print('USUARIO ID = ${user.user.uid}');
      _user = await UserService.instance.getUser(user.user.uid);
      print(email);

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