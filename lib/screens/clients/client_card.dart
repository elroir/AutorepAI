import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ingemec/models/user_model.dart';
import 'package:ingemec/styles.dart';

class ClientCard extends StatelessWidget {
  
  final User user;

  const ClientCard({Key key, this.user}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: size.width*0.5,
          maxWidth: size.width*0.7,
          minHeight: 130,
          maxHeight: 130
        ),
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
            Padding(
              padding: EdgeInsets.only(left: 10,top: 8,bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.nombre,style: Styles.titleCard,overflow: TextOverflow.clip,),
                  Text(user.email,style: Styles.clientCard,overflow: TextOverflow.clip),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(user.telefono!=0 ? user.telefono.toString() : '-',style: Styles.clientCard,),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(left: 15,bottom: 10,right: 10),
                  child: Icon(CupertinoIcons.arrow_right_circle),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
