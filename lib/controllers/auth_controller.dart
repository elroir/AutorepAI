import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


import 'package:ingemec/models/user_model.dart';
import 'package:ingemec/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthController extends GetxController {
  
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User> _firebaseUser = Rxn<User>();

  SharedPreferences _prefs;
  SharedPreferences get prefs => this._prefs;

  String get userId => this._prefs.getString('uid') ?? '';

  String get userType => this._prefs.getString('user_type') ?? 'P';


  UserModel _user = new UserModel();

  String get firebaseUser => _firebaseUser.value?.email;
  UserModel get user => _user;


  @override
  void onInit() {
    this.initPrefs();
    _firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
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

  void createUser(String email, String password, String nombre) async {


    try {
      this._prefs.setString('email', email);
      this._prefs.setString('password', password);
      final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print('USUARIO ID = ${user.user.uid}');
      this._prefs.setString('uid', user.user.uid);
      this._prefs.setString('user_type', 'P');


      _user = await UserService.instance.storeUsuario({
        "id_usuario" : user.user.uid,
        "nombre"     : nombre,
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

      final userAux =  await UserService.instance.getUserEmail( email ); 
      if(userAux.tipoUsuario == 'C'){
        Get.snackbar("Error al iniciar sesion", "Usted no es un personal", snackPosition: SnackPosition.BOTTOM);
        return;
      }

      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      this._prefs.setString('uid', user.user.uid);

      print('USUARIO ID = ${user.user.uid}');
      this._user = await UserService.instance.getUser(user.user.uid);
      this._prefs.setString('user_type', this._user.tipoUsuario);

      print(email);

      // _uid = usuario.user.uid;
    } catch (e) {
      Get.snackbar("Error al iniciar sesion", e.message, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
//      UserController userController = Get.find();
//      userController.destroy();
//      VehicleController vehicleController = Get.find();
//      vehicleController.destroy();
//      QuotesController quotesController = Get.find();
//      quotesController.destroy();
    } catch (e) {
      Get.snackbar("Error al cerrar sesion", e.message, snackPosition: SnackPosition.BOTTOM);
    }
  }

}