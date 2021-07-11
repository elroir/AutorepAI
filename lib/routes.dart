
import 'package:flutter/material.dart';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:ingemec/screens/clients/client_screen.dart';
import 'package:ingemec/screens/home_screen.dart';
import 'package:ingemec/screens/login/profile_screen.dart';
import 'package:ingemec/screens/services/service_screen.dart';
import 'package:ingemec/screens/works/works_screen.dart';

final pageRoutesSPA = <RouteSPA>[

  RouteSPA(index:0,icon: FeatherIcons.home,text: 'Inicio',page: HomeScreen()),
  RouteSPA(index:1,icon: FeatherIcons.user,text: 'Clientes',page: ClientsScreen()),
  RouteSPA(index:2,icon: FeatherIcons.clipboard,text: 'Trabajos',page: WorksScreen()),
  RouteSPA(index:3,icon: FeatherIcons.briefcase,text: 'Servicios',page: ServiceScreen()),
  RouteSPA(index:4,icon: FeatherIcons.users,text: 'Personal',page: HomeScreen()),
  RouteSPA(index:5,icon: FeatherIcons.settings,text: 'Configuracion',page: ProfileScreen()),

];


class RouteSPA {

  final int index;
  final IconData icon;
  final String text;
  final Widget page;

  RouteSPA({this.index,this.icon, this.text, this.page});

}