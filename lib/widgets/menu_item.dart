import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {

  final IconData icon;
  final String text;
  final Function onTap;

  const MenuItem({Key key, this.icon, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        width: 140,
        child: Column(
          children: [
            Icon(this.icon,size: 56,),
            Text(this.text,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 16),)
          ],
        ),
      ),
    );
  }
}
