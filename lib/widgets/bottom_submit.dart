import 'package:flutter/material.dart';

class BotonSubmit extends StatelessWidget {
  
  final Color color;
  final String texto;
  final double size;
  final Function onPress;

  BotonSubmit({
    @required this.color,
    @required this.texto,
    this.size = 15.0,
    @required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: FlatButton(
        color: this.color ,
        onPressed: this.onPress,
        child: Container(
          width: 180,
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