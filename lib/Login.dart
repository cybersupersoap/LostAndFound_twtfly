import 'package:flutter/material.dart';
import 'package:lost_and_found/NewWidgets/Dialog.dart';
import 'package:lost_and_found/RouterManager.dart';
import 'package:lost_and_found/dio_service.dart';
import 'package:lost_and_found/main.dart';

import 'Cache.dart';
import 'Config.dart';
import 'RouterManager.dart';

class LoginPage extends StatefulWidget {  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  String username='';
  String password='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsetsDirectional.all(20),
              width: 400,
              child: TextField(
                onChanged: (value){
                  username=value;
                },
                decoration: InputDecoration(
                  labelText: '用户名',
                ),
              ),
            ),
            Container(
              padding: EdgeInsetsDirectional.all(20),
              width: 400,
              child: TextField(
                onChanged: (value){
                  password=value;
                },
                decoration: InputDecoration(
                  labelText: '密码',
                ),
              ),
            ),
            Padding(padding: EdgeInsetsDirectional.only(top:50)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                    onPressed: ()async{
                      String res=await DioService.login(username, password);

                      if(res!='none'&&res.length==32){
                        Store store=await Store.getInstance();
                        await store.setString('token', res);
                        Config.token=res;
                        Config.tokenListener.value=res;
                        RouterManager.router.pop(context);
                      }else{
                        MyDialog.showCupertinoAlertDialog(context, '登录失败');
                      }
                    },
                    child: Text('登录')
                ),
                ElevatedButton(
                    onPressed:(){
                      RouterManager.router.navigateTo(context, '/register');
                    },
                    child: Text('注册'))
              ],
            )
          ],
        ),
      ),
    );
  }
}


class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPage();
  }
}

class _RegisterPage extends State<RegisterPage> {
  String username='';
  String password='';
  String password2='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsetsDirectional.all(20),
              width: 400,
              child: TextField(
                onChanged: (value){
                  username=value;
                },
                decoration: InputDecoration(
                  labelText: '请输入用户名',
                ),
              ),
            ),
            Container(
              padding: EdgeInsetsDirectional.all(20),
              width: 400,
              child: TextField(
                onChanged: (value){
                  password=value;
                },
                decoration: InputDecoration(
                  labelText: '请输入密码',
                ),
              ),
            ),
            Container(
              padding: EdgeInsetsDirectional.all(20),
              width: 400,
              child: TextField(
                onChanged: (value){
                  password2=value;
                },
                decoration: InputDecoration(
                  labelText: '重复密码',
                ),
              ),
            ),
            Padding(padding: EdgeInsetsDirectional.only(top:50)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: ()async{
                      if(username=='') MyDialog.showCupertinoAlertDialog(context, '请输入用户名');
                      else if(password=='') MyDialog.showCupertinoAlertDialog(context, '请输入密码');
                      else if(password!=password2) MyDialog.showCupertinoAlertDialog(context, '两次密码输入不一致！');
                      else{
                        String a=await DioService.register(username, password);
                        if(a=='true') RouterManager.router.pop(context);
                        else {
                          MyDialog.showCupertinoAlertDialog(context, '该用户名已注册');
                        }
                      }
                    },
                    child: Text('注册')
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
