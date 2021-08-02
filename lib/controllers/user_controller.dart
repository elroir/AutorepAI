import 'package:get/get.dart';
import 'package:ingemec/models/user_model.dart';
import 'package:ingemec/services/user_service.dart';

class UserController extends GetxController{

  List<User> _users;
  List<User> get users => this._users;
  bool _loading = true;
  bool get loading  => this._loading;


  @override
  void onReady()  {
    this.loadUsers();
    super.onReady();
  }

  Future<void> loadUsers() async {
    _users = await UserService.instance.getUsers();
    this._loading = false;
    update(['user']);
  }

  Future<void> reload() async{
    this._loading = true;
    await Future.delayed(Duration(milliseconds: 200));
    this._users.clear();
    await this.loadUsers();
  }


}