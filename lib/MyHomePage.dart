import 'package:flutter/material.dart';
import 'NewWidgets/DropDownMenu.dart';

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
      body:DropDownMenu(choices:['全部','耳机','水杯','雨伞']),
    );
  }


}