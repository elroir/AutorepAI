import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ingemec/controllers/page_controller.dart';
import 'package:ingemec/screens/client_screen.dart';
import 'package:ingemec/screens/home_screen.dart';
import 'package:ingemec/widgets/menu_item.dart';

class Menu extends StatelessWidget {

  final PageGetXController pageX = Get.put(PageGetXController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MenuItem(icon: FeatherIcons.home,text: 'Inicio',onTap: () => pageX.currentPage = HomeScreen(),),
        MenuItem(icon: FeatherIcons.user,text: 'Clientes',onTap: () => pageX.currentPage = ClientsScreen()),
        MenuItem(icon: FeatherIcons.clipboard,text: 'Trabajos',),
        MenuItem(icon: FeatherIcons.briefcase,text: 'Servicios',),
        MenuItem(icon: FeatherIcons.users,text: 'Personal',),
        MenuItem(icon: FeatherIcons.settings,text: 'Configuracion',),
      ],
    );
  }
}
