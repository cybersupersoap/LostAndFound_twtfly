import 'package:flutter/material.dart';
import 'package:lost_and_found/Config.dart';
import 'package:lost_and_found/NewWidgets/Dialog.dart';
import 'package:lost_and_found/RouterManager.dart';
import 'package:lost_and_found/dio_service.dart';

class ChangeIcon extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ChangeIconState();
  }
}

class _ChangeIconState extends State<ChangeIcon>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: (){
          RouterManager.router.pop(context);
          }
        ),
        title: Text('修改头像'),
      ),
      body:Stack(
        children: [
          Container(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              children: <Widget>[
                GestureDetector(child: IconContainer(id: 1, path: Config.userIcons[1]!),onTap: (){Config.chosenIcon=1;setState(() {});},),
                GestureDetector(child: IconContainer(id: 2, path: Config.userIcons[2]!),onTap: (){Config.chosenIcon=2;setState(() {});},),
                GestureDetector(child: IconContainer(id: 3, path: Config.userIcons[3]!),onTap: (){Config.chosenIcon=3;setState(() {});},),
                GestureDetector(child: IconContainer(id: 4, path: Config.userIcons[4]!),onTap: (){Config.chosenIcon=4;setState(() {});},),
                GestureDetector(child: IconContainer(id: 5, path: Config.userIcons[5]!),onTap: (){Config.chosenIcon=5;setState(() {});},),
                GestureDetector(child: IconContainer(id: 6, path: Config.userIcons[6]!),onTap: (){Config.chosenIcon=6;setState(() {});},),
                GestureDetector(child: IconContainer(id: 7, path: Config.userIcons[7]!),onTap: (){Config.chosenIcon=7;setState(() {});},),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
              child: Container(
                child: ElevatedButton(
                  child: Text('修改头像'),
                  onPressed: ()async{
                    String a=await DioService.changeIcon(Config.token,Config.chosenIcon);
                    if(a=='true'){
                      MyDialog.showCupertinoAlertDialog(context, '修改成功!');
                    }else{
                      MyDialog.showCupertinoAlertDialog(context, '修改失败');
                    }
                  },
                ),
              )
          )
        ],
      )
    );
  }
}

class IconContainer extends StatefulWidget {
  final int id;
  final String path;
  IconContainer({Key? key,required this.id,required this.path}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _IconContainerState();
  }
}

class _IconContainerState extends State<IconContainer>{

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image(
          image: AssetImage(widget.path),
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: Config.chosenIcon==widget.id? Colors.blue:Colors.white,
              width: 2,
            )
        ),
    );
  }

}

