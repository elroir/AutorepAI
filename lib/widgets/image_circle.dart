import 'package:flutter/material.dart';

class ImageCircle extends StatelessWidget {
  
  final String imageSource;
  final String imageAsset;
  final double height;

  ImageCircle({
    this.imageSource, 
    this.imageAsset, 
    @required this.height
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: this.height,
        height: this.height,
        child: ( imageSource != null )
          ? Image.network(
             this.imageSource,
             fit: BoxFit.cover,
          )
          : Image(
             fit: BoxFit.cover,
             image: AssetImage( this.imageAsset ?? 'assets/mec-icon.png'),
            //  image: AssetImage( this.imageAsset ?? 'assets/no-image.png'),
          )
      ),
    );
  }
}