
import 'package:flutter/material.dart';

class SubcajitaWidget extends StatelessWidget {

  final String title;
  final String subtitle;
  final Color color;
  final double fontSize;

  final Widget body;
  final double heightBody;

  final Color colorCajitaP;

  const SubcajitaWidget({
    Key key, 
    @required this.title, 
    @required this.subtitle, 
    this.color = Colors.white54,
    
    this.fontSize = 15, 
    this.body, 
    this.heightBody = 0,
    this.colorCajitaP = Colors.blue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [ 
          _contenidoTitulo(subtitle, size),
          Positioned(
            left: size.width*0.52, top: 10,
            // left: size.width*0.6, top: 10,
            // left: 220, top: 10,
            height: 45, width: 150,
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: this.colorCajitaP
              ),
              child: Padding(
                padding: EdgeInsets.symmetric( horizontal: 25, vertical: 15),
                child: Center(
                  child: Text( this.title, 
                    style: TextStyle( 
                      fontSize: this.fontSize, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.white,
                    )
                  )
                ),
              )
            ),
          ),
        ]
      ),
    );
  }

  Padding _contenidoTitulo(String text, Size size) {
    return Padding(
      padding: EdgeInsets.symmetric( horizontal: 15, vertical: 25),
      child: Container(
        width: size.width,
        height: (80 + this.heightBody).toDouble(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: this.color
        ),
        child: Column(
          children: [
            Padding(                
              padding: EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Text(text, 
                style: TextStyle( 
                  fontWeight: FontWeight.bold, 
                  fontSize: 18
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                width: 270,
                height: this.heightBody,
                child: this.body ?? Container(),
              ),
            )
          ],
        ),
      ),
    );
  }
}