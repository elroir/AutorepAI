
import 'package:flutter/material.dart';

class AppBarLogo extends StatelessWidget {

  AppBarLogo({
    @required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.22, //.25
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor
      ),
     child: SafeArea(
       child: Column(
         children: [
            SizedBox( height: 14),//13
            _LogoContainer(size: size),
         ],
       ),
     )
    );
  }
}

class _LogoContainer extends StatelessWidget {
  
  _LogoContainer({
    @required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.17, //0.15
      width: size.width * 0.8,  //0.8
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white70
      ),
      child: Image(image: AssetImage('assets/logo.png'))
    );
  }
}