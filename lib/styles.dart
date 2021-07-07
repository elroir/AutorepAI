
import 'package:flutter/material.dart';

class Themes {


  static ThemeData themeData() {
    return ThemeData(
      primaryColor: Colors.white,
      // primaryColor: Color(0xFFDC4D4E),
      // primaryColorDark: Color(0xFF071223),
      primaryColorDark: Colors.white,
      backgroundColor: Colors.white,
      // backgroundColor: Color(0xFF122034),
      // cardColor: Color(0xFF192C47),
      cardColor: Colors.white,
      iconTheme: IconThemeData(size: 30, color: Color(0xFFDC4D4E)),
      scaffoldBackgroundColor: Colors.white,
      // scaffoldBackgroundColor: Color(0xFF122034),
      canvasColor: Color(0xFF071223),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFDC4D4E))
      ),
      fontFamily: 'Roboto'

    );
  }

}
