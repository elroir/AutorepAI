
import 'package:ingemec/routes.dart';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ingemec/screens/client_screen.dart';
import 'package:ingemec/screens/home_screen.dart';
import 'package:ingemec/screens/servicios/create_service_screen.dart';
import 'package:ingemec/screens/servicios/registrar_screen.dart';
import 'package:ingemec/screens/servicios/service_screen.dart';
import 'package:ingemec/screens/works_screen.dart';

class Routes2{

  static Routes2 _instance = Routes2();
  static Routes2 get instance => _instance;

  List<RouteSPA> _routes = <RouteSPA>[

  RouteSPA(index:0,icon: FeatherIcons.home,text: 'Inicio',page: HomeScreen()),
  RouteSPA(index:1,icon: FeatherIcons.user,text: 'Clientes',page: ClientsScreen()),
  RouteSPA(index:2,icon: FeatherIcons.clipboard,text: 'Trabajos',page: WorksScreen()),
  RouteSPA(index:3,icon: FeatherIcons.briefcase,text: 'Servicios',page: ServiceScreen()),
  RouteSPA(index:4,icon: FeatherIcons.users,text: 'Personal',page: HomeScreen()),
  RouteSPA(index:5,icon: FeatherIcons.settings,text: 'Configuracion',page: HomeScreen()),

  RouteSPA(index:6,icon: FeatherIcons.settings,text: 'CreateServicio',page: CreateServiceScreen()),
  RouteSPA(index:7,icon: FeatherIcons.settings,text: 'RegisterServicio',page: RegisterScreen())
];

  List<RouteSPA> get routes => _routes;

  RouteSPA getRoute(String text){
    for (var item in _routes) {
      if (item.text.compareTo(text) == 0) {
        return item;
      }
    }
    return null;
  }

}