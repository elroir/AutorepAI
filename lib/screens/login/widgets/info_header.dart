import 'package:flutter/material.dart';
import 'package:ingemec/widgets/header_background.dart';


class InfoHeaderLogin extends StatelessWidget {
  InfoHeaderLogin();

  @override
  Widget build(BuildContext context) {
    
    final width  = MediaQuery.of(context).size.width;

    final double data = 80;

    return Stack(
      children: <Widget>[
        Positioned(
          top: 90,
          child: HeaderWidgetBackground(
            width: width, height: 350,
            bottomLeft: data, bottomright: data,
            topLeft:    data, topright:    data,
            color1: Color(0xFFd34141),
            color2: Color(0xFFd34141),
          )
        ),
       
        Positioned(
          top: 170, left: 45,
          child: Icon(
            Icons.settings,
            size: 65, color: Colors.black
          )
        ),
        Row(
          children: <Widget>[
            SizedBox( width: 110 ),
            Column(
              children: <Widget>[
                SizedBox( height: 172 ),
                Text('Franco Motors!',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold
                  )
                ),
                Text('Servicios de calidad!',
                  style: TextStyle( fontSize: 15 )
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
