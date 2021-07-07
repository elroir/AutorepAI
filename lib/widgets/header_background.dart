
import 'package:flutter/material.dart';

class HeaderWidgetBackground extends StatelessWidget {
  
  final Color color1;
  final Color color2;

  final double bottomLeft;
  final double bottomright;
  final double topLeft;
  final double topright;

  final double height;
  final double width;

  final Widget child;

  HeaderWidgetBackground({
    @required this.color1,
    @required this.color2, 
    this.bottomLeft  = 0, 
    this.bottomright = 0, 
    this.topLeft     = 0, 
    this.topright    = 0,
    this.height      = 270,
    @required this.width,
    this.child
  });

  @override
  Widget build(BuildContext context) {
   
    //final width = MediaQuery.of(context).size.width;

    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(this.bottomLeft),
          bottomRight:Radius.circular(this.bottomright) ,
          topLeft: Radius.circular(this.topLeft),
          topRight: Radius.circular(this.topright)
          //Radius.circular(80)
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            this.color1,
            this.color2,
            
          ]
        )
      ),
      child: this.child ?? Container(),
    );
  }
}