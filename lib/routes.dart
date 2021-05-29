
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ingemec/screens/client_screen.dart';
import 'package:ingemec/screens/home_screen.dart';
import 'package:ingemec/screens/works_screen.dart';

final pageRoutesSPA = <RouteSPA>[

  RouteSPA(index:0,icon: FeatherIcons.home,text: 'Inicio',page: HomeScreen()),
  RouteSPA(index:1,icon: FeatherIcons.user,text: 'Clientes',page: ClientsScreen()),
  RouteSPA(index:2,icon: FeatherIcons.clipboard,text: 'Trabajos',page: WorksScreen()),
  RouteSPA(index:3,icon: FeatherIcons.briefcase,text: 'Servicios',page: HomeScreen()),
  RouteSPA(index:4,icon: FeatherIcons.users,text: 'Personal',page: HomeScreen()),
  RouteSPA(index:5,icon: FeatherIcons.settings,text: 'Configuracion',page: HomeScreen()),

];



class RouteSPA {

  final int index;
  final IconData icon;
  final String text;
  final Widget page;

  RouteSPA({this.index,this.icon, this.text, this.page});

}