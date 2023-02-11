import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value){
            setState(() {

            });
          },
        ),
      ),
    );
  }
}
