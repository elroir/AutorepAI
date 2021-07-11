import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(50),
        image: DecorationImage(
          image: AssetImage('assets/no-image.png'),
          fit: BoxFit.cover
        )
      ),
    );
  }
}