


import 'dart:convert';

import 'package:get/get.dart';
import 'package:ingemec/Env.dart';
import 'package:ingemec/models/follow_model.dart';
import 'package:http/http.dart' as http;

class FollowsService {

  static FollowsService _instance = FollowsService();
  static FollowsService get instance => _instance;

  Future<void> newFollow(Follow follow) async {
      print(follow.toJson());
      final uri = Uri.http( Env.url, '/api/storeDetalleSeguimiento', );
      final resp = await http.post(uri,body: follow.toJson());
      final decodedData = json.decode(resp.body);


  }

  Future<List<Follow>> getFollow(int id) async {
      final uri = Uri.http( Env.url, '/api/getDetallesSeguimiento',{
        "id_orden" : id.toString()
      } );
      final resp = await http.get(uri);
      print(resp.body);
      final decodedData = json.decode(resp.body);
      final List<Follow> follows = [];
      (decodedData['data'] as List).forEach((vehicle) {
        follows.add(Follow.fromJson(vehicle));
      });
      return follows;


  }


}