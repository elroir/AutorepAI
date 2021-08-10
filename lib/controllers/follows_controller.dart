import 'package:get/get.dart';

class FollowController extends GetxController {

  List<dynamic> _follows;
  List get follows => this._follows;

  bool _loading = true;
  bool get loading  => this._loading;

  @override
  void onReady()  {
    this.loadFollows();
    super.onReady();
  }


  Future<void> loadFollows() async {
    this._follows = [];
    this._loading = false;
    update(['follows']);
  }

}