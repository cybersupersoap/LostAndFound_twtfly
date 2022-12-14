import 'package:flutter/material.dart';


class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome'
        ),
      ),
      body:Align(
        alignment: Alignment(0.0,-0.8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 100,
              height: 150,
              color: Colors.red,
            ),
            Container(
              width: 100,
              height: 150,
              color: Colors.blue,
            )
          ],
        ),
      )
    );
  }


}