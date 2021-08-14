import 'package:get/get.dart';
import 'package:ingemec/models/user_model.dart';
import 'package:ingemec/services/user_service.dart';

class UserController extends GetxController{

  List<UserModel> _users;
  List<UserModel> get users => this._users;

  List<UserModel> _workers;
  List<UserModel> get workers => this._workers;
  bool _loading = true;
  bool get loading  => this._loading;


  @override
  void onReady()  {
    this.loadUsers();
    this.loadWorkers();
    super.onReady();
  }

  Future<void> loadUsers() async {
    this._users = await UserService.instance.getUsers();
    this._loading = false;
    update(['user']);
  }

  Future<void> loadWorkers() async {
    this._workers = await UserService.instance.getWorkers();
    this._loading = false;
    update(['user']);
  }

  Future<void> reload() async{
    this._loading = true;
    this._users.clear();
    update(['user']);
    await this.loadUsers();
  }

  void destroy() {
    this._loading = true;
    this._users.clear();
    this._workers.clear();
    update();
  }


}