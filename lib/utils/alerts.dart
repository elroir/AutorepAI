import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void optionsAlert(BuildContext context,String title, String content,Function onPressed,{List<Widget> actions}) {

  if (actions==null) {
    actions = [
      TextButton(
        child: Text('Volver'),
        onPressed: () => Navigator.of(context).pop(),
      ),
      TextButton(
        child: Text('Si'),
        onPressed: onPressed,
      )

    ];
  }

  if (Platform.isAndroid) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: actions
        )
    );
  } else {
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: actions
        )
    );

  }
}