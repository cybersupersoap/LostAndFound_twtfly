///修改呢称
import 'package:flutter/material.dart';
import 'package:lost_and_found/NewWidgets/Dialog.dart';
import 'package:lost_and_found/dio_service.dart';

import '../../Config.dart';

class NickNamePage extends StatelessWidget {
  const NickNamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String cname="";
    return Scaffold(
        appBar: AppBar(
          title: Text('修改用户名'),
        ),
        body: SafeArea(
            minimum: EdgeInsets.all(30),
            child: ListView(
              children: [
                TextField(
                  decoration:
                      InputDecoration(labelText: ('昵称'), hintText: ('请修改昵称')),
                  onChanged: (value){
                    cname=value;
                  },
                ),
                OutlinedButton(onPressed: () async{
                  if(cname!=""){
                    var a=await DioService.changeUsername(Config.token, cname);
                    if(a=="true"){
                      MyDialog.showCupertinoAlertDialog(context, "修改成功");
                    }else{
                      MyDialog.showCupertinoAlertDialog(context, "名称已存在");
                    }
                  }
                }, child: Text('确定'))
              ],
            )));
  }
}
