
import 'package:flutter/material.dart';

class ModalProgressIndicator extends StatelessWidget {
  
  final Widget body;
  final String texto;
  final Color color;
  final bool isloading;

  ModalProgressIndicator({
    @required this.body, 
    this.texto = 'Esta cargando', 
    this.color = Colors.lightBlue,
    this.isloading = false
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          body,

          (isloading)?
          Container(
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: _ProgressIndicator(
              texto: this.texto,
              color: this.color,
            ) 
          )
          : Container()
        ],
      ),
    );

  }
}

class _ProgressIndicator extends StatelessWidget {
  
  final String texto;
  final Color color;

  _ProgressIndicator({ 
    this.texto , 
    this.color 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFF5173AF),
            Color(0xFF5173AF),
          ]
        ),
        borderRadius: BorderRadius.circular(10.0)
      ),
      width: 300.0,
      height: 200.0,
      alignment: AlignmentDirectional.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: SizedBox( height: 50.0, width: 50.0,
              child: CircularProgressIndicator(
                value: null, strokeWidth: 7.0,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25.0),
            child: Center(
              child: Text( this.texto,
                style:TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
        ],
      )                   
    );
  }
}