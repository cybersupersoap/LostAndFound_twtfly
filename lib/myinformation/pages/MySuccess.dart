import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySuccessPage extends StatefulWidget {
  const MySuccessPage({Key? key}) : super(key: key);

  @override
  State<MySuccessPage> createState() => _MySuccessPageState();
}

class _MySuccessPageState extends State<MySuccessPage> {
  @override
  Widget build(BuildContext context) {
    var Height = MediaQuery.of(context).size.height;
    var Width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: new DecorationImage(
              image: AssetImage('assets/background.png'), fit: BoxFit.cover)),
      child: Column(
        children: [
          Container(
            height: 100,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                SizedBox(width: Width / 4.5),
                Text(
                  '我的成就',
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white38),
            margin: EdgeInsets.all(15),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      '捡起10件物品',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '下一个目标:',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '达成时间 2022/12/29',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white38),
            margin: EdgeInsets.all(15),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      '发帖100次',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '下一个目标:',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '达成时间 2022/12/24',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
