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
          _BotonItemBackground( this.color1, this.color2 ),
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

  _BotonItemBackground( this.color1, this.color2 );

  @override
  Widget build(BuildContext context) {
    return Container(

      width: double.infinity,
      height: 100,
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