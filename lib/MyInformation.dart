import 'package:flutter/material.dart';
import 'package:lost_and_found/RouterManager.dart';
import 'package:lost_and_found/dio_service.dart';

import 'Cache.dart';
import 'Config.dart';

class MyInformationPage extends StatefulWidget {
  const MyInformationPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyInformationPage();
  }
}

class _MyInformationPage extends State<MyInformationPage> {
  var username;
  var icon;

  void onRefresh()async{
    var userid=await DioService.getUserid(Config.token);
    print(userid);
    username=Future.value(await DioService.getUsername(userid));
    icon=Future.value(await DioService.geticon(userid));
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    onRefresh();
  }


  // void onInit()async{
  //   if(Config.token=='none'||Config.token.length<32){
  //     RouterManager.router.navigateTo(context, 'login');
  //   }else{
  //     username=Future.value(await DioService.get)
  //   }
  //
  // }

  @override
  Widget build(BuildContext context) {
    ///根据手机屏幕调节高度
    var Height = MediaQuery.of(context).size.height;
    var Width = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/background.png'),
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: Config.tokenListener,
          builder: (context, snapshot,child) {
            if(Config.token!='none'&&Config.token.length==32)
            return Column(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(30, 40, 30, 30),
                    height: Height / 5,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(children: [
                      ///头像部分,上传图像的功能还没有
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.all(20),
                              child: FutureBuilder(
                                future: icon,
                                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                  if(snapshot.connectionState==ConnectionState.done){
                                    return GestureDetector(
                                        child: Image(image: AssetImage(Config.userIcons[snapshot.data]!),fit: BoxFit.fitWidth,),
                                      onTap: (){
                                          RouterManager.router.navigateTo(context, '/changeIcon');
                                      },
                                    );
                                  }else{
                                    return Container();
                                  }
                                },

                              )
                              /*Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage('assets/bird.jpg'))),
                            ),*/
                              ),
                          Text('点击图片修改头像',style: TextStyle(color: Colors.grey),),
                        ],
                      ),

                      ///昵称部分
                      Container(
                        padding: EdgeInsetsDirectional.only(start: 20),
                        child: FutureBuilder(
                          future: username,
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if(snapshot.connectionState==ConnectionState.done){
                              return Text(snapshot.data,style: TextStyle(fontSize: 20),);
                            }else{
                              return Text('加载中');
                            }
                          },

                        ),
                        //height: 50,
                      ),

                      ///icon用于修改昵称
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/change_name');
                          },
                          icon: Image(
                              image: AssetImage(
                            'assets/nickname.png',
                          ))),
                      Padding(padding: EdgeInsetsDirectional.only(start: 20)),
                      IconButton(onPressed: (){onRefresh();}, icon: Icon(Icons.refresh))
                    ])),

                Row(
                  children: [
                    ///我的消息
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'my_message');
                      },
                      child: Container(
                        width: (Width - 90) / 2,
                        height: Height / 4,
                        margin: EdgeInsets.fromLTRB(30, 15, 15, 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white70),
                        child: Column(
                          children: [
                            Container(
                                width: (Width - 90) / 2 - 70,
                                height: Height / 4 - 70,
                                child: Image(
                                    image: AssetImage('assets/my_message.png'))),
                            Text(
                              '我的消息',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),

                    ///发帖记录
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'post_record');
                      },
                      child: Container(
                          width: (Width - 90) / 2,
                          height: Height / 4,
                          margin: EdgeInsets.fromLTRB(15, 15, 30, 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white70),
                          child: Column(
                            children: [
                              Container(
                                child: Image(
                                  width: (Width - 90) / 2 - 70,
                                  height: Height / 4 - 70,
                                  image: AssetImage('assets/my_record.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Text(
                                '发帖记录',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          )),
                    ),
                  ],
                ),

                ///我的成就
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'my_success');
                    },
                    child: Container(
                        margin: EdgeInsets.all(30),
                        height: Height / 6,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Image(image: AssetImage('assets/my_achievement.png')),
                            Text(
                              '我的成就',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ))),
                Container(
                  child: ValueListenableBuilder(
                    valueListenable: Config.tokenListener,
                    builder: (context, value, child) {
                      return ElevatedButton(
                        child: Config.token != 'none' && Config.token.length == 32
                            ? Text('注销')
                            : Text('登录'),
                        onPressed: () async {
                          if (Config.token != 'none' && Config.token.length == 32) {
                            Config.token = 'none';
                            Config.tokenListener.value = 'none';
                            Store store = await Store.getInstance();
                            await store.remove('token');
                          } else {
                            RouterManager.router.navigateTo(context, 'login');
                          }
                        },
                      );
                    },
                    child: ElevatedButton(
                      child: Config.token != 'none' && Config.token.length == 32
                          ? Text('注销')
                          : Text('登录'),
                      onPressed: () async {
                        if (Config.token != 'none' && Config.token.length == 32) {
                          Config.token = 'none';
                          Config.tokenListener.value = 'none';
                          Store store = await Store.getInstance();
                          await store.remove('token');
                        } else {
                          RouterManager.router.navigateTo(context, 'login');
                        }
                      },
                    ),
                  ),
                )
              ],
            );
            else return Center(
              child: ElevatedButton(
                child: Config.token != 'none' && Config.token.length == 32
                    ? Text('注销')
                    : Text('登录'),
                onPressed: () async {
                  if (Config.token != 'none' && Config.token.length == 32) {
                    Config.token = 'none';
                    Config.tokenListener.value = 'none';
                    Store store = await Store.getInstance();
                    await store.remove('token');
                  } else {
                    RouterManager.router.navigateTo(context, 'login');
                  }
                },
              ),
            );
          }
        ));
  }
}
