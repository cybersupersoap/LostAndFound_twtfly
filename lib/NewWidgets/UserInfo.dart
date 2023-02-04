import 'package:flutter/material.dart';


class UserInfo extends StatelessWidget {
  final String username;
  UserInfo({Key?key,required String this.username}):super(key:key);
  @override
  Widget build(BuildContext context) {
   return GestureDetector(
     child: Container(
       child: Row(
         children: <Widget>[

         ],
       ),
     ),
   );
  }
}
