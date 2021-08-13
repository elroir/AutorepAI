import 'package:get/get.dart';
import 'package:ingemec/models/follow_model.dart';
import 'package:ingemec/services/follows_service.dart';

class FollowController extends GetxController {

  final int id;
  FollowController({this.id});

  List<Follow> _follows;
  List<Follow> get follows => this._follows;

  bool _loading = true;
  bool get loading  => this._loading;

  Follow currentFollow;

  @override
  void onInit()  {

    print(this.id);
    this._follows = [];
    super.onInit();
  }

  @override
  void onReady()  {
    this.loadFollows();
    super.onReady();
  }


  Future<void> newFollow () async {
    await FollowsService.instance.newFollow(this.currentFollow);
  }


  Future<void> loadFollows() async {
    this._loading = true;
    update(['follows']);
    this._follows = await FollowsService.instance.getFollow(this.id);
    this._loading = false;
    update(['follows']);
  }

}