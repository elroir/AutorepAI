import 'package:flutter/material.dart';


class SeguimientosScroll extends StatelessWidget {

  final List<Widget> list;

  const SeguimientosScroll( {this.list} );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: this.list.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 13),
          child: list[index],
        );
     },
    );
  }
}

class SeguimientoItem extends StatelessWidget {
  
  final String pathImage;
  final String textSubtitle;

  const SeguimientoItem({
    @required this.pathImage, 
    @required this.textSubtitle
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).primaryColor
      ),
      child: Column(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              // color: Colors.pink,
              image: DecorationImage(
                image: AssetImage(this.pathImage),
                fit: BoxFit.cover
              )
            ),
          ),
          SizedBox( height: 5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                color: Colors.black26
                // color: Colors.white70
              ),
              child: Center(child: Text(this.textSubtitle)),
            ),
          )
        ],
      ),
    );
  }
}