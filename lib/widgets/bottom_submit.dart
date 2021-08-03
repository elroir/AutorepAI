import 'package:flutter/material.dart';

class BotonSubmit extends StatelessWidget {
  
  final Color color;
  final String texto;
  final double size;
  final Function onPress;
  final double width;
  final double borde;

  BotonSubmit({
    @required this.color,
    @required this.texto,
    this.size = 15.0,
    @required this.onPress, this.width = 180, this.borde = 100
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(this.borde),
      child: FlatButton(
        color: this.color ,
        onPressed: this.onPress,
        child: Container(
          width: this.width,
          height: 50,
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