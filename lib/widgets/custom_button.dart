import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final Function onPressed;
  final Widget child;
  final double width;
  final Color color;

  const CustomButton({Key key, this.onPressed, this.width, this.color,this.child}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width ?? MediaQuery.of(context).size.width *0.9 ,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              primary: Theme.of(context).primaryColorDark
          ),
          onPressed: this.onPressed ?? (){},
          child: this.child ?? SizedBox()
      ),
    );
  }
}
