import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyDialog{
  static void showCupertinoAlertDialog(BuildContext context,String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(message),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("确定"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

}