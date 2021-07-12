import 'dart:io';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ingemec/widgets/image_circle.dart';

class BotonItem extends StatelessWidget {

  @required final String texto;
  final Color color1;
  final Color color2;
  @required final Function onPress;
  final String imageSource;

  const BotonItem({
    this.texto,
    this.color1 = Colors.grey,
    this.color2 = Colors.blueGrey,
    this.onPress,
    this.imageSource
  });

  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPress,
      child: Stack(
        children: <Widget>[
          _BotonItemBackground( color1: this.color1, color2: this.color2 ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox( height: 140, width: 40 ),
              ImageCircle( imageSource : this.imageSource, height: 55,),

              SizedBox( width: 20 ),
              Expanded(child: Text( this.texto, style: TextStyle( color: Colors.white, fontSize: 18 ) )),
              FaIcon( FontAwesomeIcons.chevronRight, color: Colors.white ),
              SizedBox( width: 40 ),
            ],
          )

        ],
      ),
    );
  }
}


class _BotonItemBackground extends StatelessWidget {
  
  final Color color1;
  final Color color2;
  final double height ;

  _BotonItemBackground( {this.color1, this.color2, this.height = 100} );

  @override
  Widget build(BuildContext context) {
    return Container(

      width: double.infinity,
      height: this.height,
      margin: EdgeInsets.all( 20 ),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow( 
            color: Colors.black.withOpacity(0.2), 
            offset: Offset(4,6), blurRadius: 10 
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: <Color>[
            this.color1,
            this.color2,
          ]
        )
      ),
    );
  }
}


class BotonImageItem extends StatelessWidget {

  @required final String texto;
  final Color color1;
  final Color color2;
  @required final Function onPress;
  final File foto;

  const BotonImageItem({
    this.texto,
    this.color1 = Colors.grey,
    this.color2 = Colors.blueGrey,
    this.onPress,
    this.foto
  });

  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPress,
      child: Stack(
        children: <Widget>[
          _BotonItemBackground( color1: this.color1, color2: this.color2, height: 150, ),
          Padding(
            padding: EdgeInsets.only( top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox( height: 140, width: 40 ),
                imageFromFile(height: 120, foto: this.foto),

                SizedBox( width: 50 ),
                Expanded(child: Text( this.texto, style: TextStyle( color: Colors.white, fontSize: 18 ) )),
                FaIcon( FontAwesomeIcons.chevronRight, color: Colors.white ),
                SizedBox( width: 40 ),
              ],
            ),
          )

        ],
      ),
    );
  }

  Widget imageFromFile({double height, File foto}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: height,
        height: height,
        child:  (foto != null) 
        ? Image.file(
          foto,
          height: 100.0,
        )
        : Image.asset('assets/no-image.png'),
      ),
    );
  }
}
