import 'package:flutter/material.dart';

import 'custom_button.dart';

class CardButton extends StatelessWidget {

  final Function onPressed;
  final IconData icon;
  final String text;
  final double height;
  final double width;

  const CardButton({Key key, this.onPressed, this.icon, this.text, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Size size =  MediaQuery.of(context).size;

    return Container(
      height: this.height!=null ? this.height : size.width*0.42 ,
      child: CustomButton(
        width: this.width!=null ? this.width : size.width*0.42,
        onPressed: this.onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(this.icon,color: Theme.of(context).primaryColor,size: 40,),
            SizedBox(height: 10,),
            Text(this.text,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),)
          ],
        ),
      ),
    );
  }
}