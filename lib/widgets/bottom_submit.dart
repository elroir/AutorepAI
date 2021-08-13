import 'package:flutter/material.dart';

class BotonSubmit extends StatelessWidget {
  
  final Color color;
  final String texto;
  final double size;
  final Function onPress;
  final double width;
  final double borde;
  final double height;

  BotonSubmit({
    @required this.color,
    @required this.texto,
    this.size = 15.0,
    @required this.onPress, this.width = 180, this.borde = 100, this.height = 50
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(this.borde),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: this.color
        ),
        onPressed: this.onPress,
        child: Container(
          width: this.width,
          height: this.height,
          child: Center(
            child: Text( this.texto, 
              style: TextStyle(
                fontSize: this.size,
                fontWeight: FontWeight.bold 
              ), 
            )
          ),
        ),
      ),
    );
  }
}