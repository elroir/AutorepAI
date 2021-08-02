
import 'package:flutter/material.dart';

class Themes {
  static ThemeData themeData() {
    return ThemeData(
      primaryColor: Color(0xFFDC4D4E),
      primaryColorDark: Color(0xFF071223),
      backgroundColor: Color(0xFF122034),
      cardColor: Color(0xFF192C47),
      iconTheme: IconThemeData(size: 30, color: Color(0xFFDC4D4E)),
      scaffoldBackgroundColor: Color(0xFF122034),
      canvasColor: Color(0xFF071223),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFDC4D4E))
      ),
      textTheme: TextTheme(
        bodyText2: TextStyle(color: Colors.white)
      ),
      fontFamily: 'Roboto'

    );
  }
}

class Styles {

  static final TextStyle clientCard = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 16
  );

  static final TextStyle titleCard = TextStyle(
    color:  Color(0xFFDC4D4E),
    fontSize: 22,
    fontWeight: FontWeight.w900,
  );

}

