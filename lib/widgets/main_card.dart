import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {

  final List<Widget> children;
  final double width;
  final double height;

  const MainCard({Key key,this.children,this.width=250,this.height=200}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: this.width,
        height: this.height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 8,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)
                  )
              ),
            ),
            ...this.children

          ],
        ),
      ),
    );
  }
}
