
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:ingemec/models/user_model.dart';

class UserService{

  static UserService _instance = UserService();
  static UserService get instance => _instance;

  final _dbUrl = '34.132.85.203';

  Future<List<UserModel>> getUsers( ) async {
    final uriFinal = Uri.http( _dbUrl, '/api/getUsuarios' );
    final resp = await http.get(uriFinal);
    final List<UserModel> users = [];
    final decodedData = json.decode(resp.body);
    (decodedData['data'] as List).forEach((user) {
      users.add(UserModel.fromJson(user));
    });


    return users;

  }

  Future<List<UserModel>> getWorkers( ) async {
    final uriFinal = Uri.http( _dbUrl, '/api/getPersonal' );
    final resp = await http.get(uriFinal);
    final List<UserModel> users = [];
    final decodedData = json.decode(resp.body);
    (decodedData['data'] as List).forEach((user) {
      users.add(UserModel.fromJson(user));
    });


    return users;

  }

  Future<UserModel> getUser( String usuarioid ) async {
    final data = {"id_usuario" : usuarioid};
    final uriFinal = Uri.http( _dbUrl, '/api/getUsuarioId', data );
    final resp = await http.get(uriFinal);
    final decodedData = json.decode(resp.body); //trasforma en un mapa
   
    print('$decodedData dataS');

    if( decodedData == null ) return new UserModel();

    UserModel user = usuarioFromJson1(decodedData['data'][0]);
    // User user = usuarioFromJson(resp.body);
    print(user.nombre);
    return user;
    
  }

  Future<UserModel> storeUsuario(Map<String, String> data) async {
    
    final urifinal = Uri.http( _dbUrl, '/api/storeUsuario', data );
    final resp = await http.post(urifinal);
    final decodedData = json.decode(resp.body); //trasforma en un mapa
    print('paso por aqui USUARIO');
    print(decodedData["ok"]);
    print(decodedData["data"][0]);
    print(decodedData["data"][0]["id_usuario"]);
    UserModel us = usuarioFromJson1(decodedData["data"][0]);
    return (decodedData["ok"]) 
    ? us
    : new UserModel();
   
  }

  Future<String> storeUsuario2(Map<String, String> data) async {
    
    final urifinal = Uri.http( _dbUrl, '/api/storeUsuario', data );
    final resp = await http.post(urifinal);
    final decodedData = json.decode(resp.body); //trasforma en un mapa
    print('paso por aqui USUARIO');
    print(decodedData["ok"]);
    return (decodedData["ok"]) ? 'Se añadió correctamente el usuario' : 'nou';
   
  }
}