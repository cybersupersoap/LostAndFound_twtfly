import 'package:flutter/material.dart';
import 'package:lost_and_found/NewWidgets/PostContainer.dart';
import 'package:lost_and_found/dio_service.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'Cache.dart';
import 'Config.dart';
import 'Models/Post.dart';
import 'NewWidgets/DropDownMenu.dart';
import 'RouterManager.dart';

import 'TestFile.dart';
import 'package:dio/dio.dart';

class LostandFoundMenu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_LostandFoundMenuState ();
}

class _LostandFoundMenuState extends State<LostandFoundMenu> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  Future<List<PostContainer>> foundPosts=Future.value([]);
  Future<List<PostContainer>> lostPosts=Future.value([]);
  String keyWord='';
  String item='全部';
  static const List<Widget> homeTopTabList =[
    Text(
      '拾物',
      style: TextStyle(
        color: Colors.blueGrey,
        fontSize: 20,
      ),
    ),
    Text(
      '失物',
      style: TextStyle(
        color: Colors.blueGrey,
        fontSize: 20,
      ),
    )
  ];//上部标签栏

  @override
  void initState() {
    super.initState();
    _tabController=TabController(length: homeTopTabList.length, vsync: this);
    onRefresh();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  Future<void> onRefresh() async {
    var resPosts = await DioService.searchBySingleKey(keyWord);
    List<PostContainer> temLostPosts=[];
    List<PostContainer> temFoundPosts=[];
    for(int i=resPosts.length-1;i>=0;i--){
      //print(resPosts[i].userid);
      if(resPosts[i].LFtype=='失物'&&(item==resPosts[i].itemKind||item=='全部')&&resPosts[i].WorJ==Config.campus) temLostPosts.add(PostContainer(post: resPosts[i]));
      else if(resPosts[i].LFtype=='拾物'&&(item==resPosts[i].itemKind||item=='全部')&&resPosts[i].WorJ==Config.campus) temFoundPosts.add(PostContainer(post: resPosts[i]));
    }
    setState(() {
      foundPosts = Future.value(temFoundPosts);
      lostPosts = Future.value(temLostPosts);
    });

  }

  void callbackfunc(String? itemKind){
    if(itemKind==null) item='全部';
    else{
      item=itemKind;
    }
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: DropDownMenu(choices:const ['全部','卡片','手机','电脑','钥匙','其他'],width:100,callbackfunc: callbackfunc),//下拉选单
          leadingWidth: 100,
          title: TextField(
            onChanged: (value){
              if(value==null) {
                keyWord = '';
                return;
            }
              keyWord=value;
            },
          ),
          bottom: TabBar(
            tabs:homeTopTabList,
            controller: _tabController,
          ),
          actions:<Widget>[
            Padding(
              padding: const EdgeInsets.only(right:15),
              child: IconButton(
                icon: Icon(Icons.search),
                color: Colors.blue,
                onPressed: (){
                  onRefresh();
                },
              )
            ),
          ]
        ),

        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Stack(
                  children: <Widget>[
                    Container(
                        child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            FutureBuilder(
                              future: foundPosts,
                              builder: (context,snapshot){
                                if(snapshot.connectionState ==ConnectionState.done){
                                  if(snapshot.hasError) return Container(child: Center(child: Text('Error'),),);
                                  else return Container(
                                    child: RefreshIndicator(
                                      onRefresh: onRefresh,
                                      child: snapshot.data!.isEmpty? ListView(
                                        children: [
                                          Container(child: Center(child: Text('暂无'),),),
                                        ],
                                      ):
                                      ListView.separated(
                                        key: UniqueKey(),
                                        itemBuilder: (BuildContext context, int index) {
                                          return snapshot.data![index];
                                        },
                                        separatorBuilder: (BuildContext context, int index) {
                                          return Divider(height: 1,color: Colors.grey,);
                                        },
                                        itemCount: snapshot.data!.length,
                                      ),
                                    ),
                                  );
                                }else return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                            FutureBuilder(
                              future: lostPosts,
                              builder: (context,snapshot){
                                if(snapshot.connectionState ==ConnectionState.done){
                                  if(snapshot.hasError) return Container(child: Center(child: Text('Error'),),);
                                  else return Container(
                                    child: RefreshIndicator(
                                      onRefresh: onRefresh,
                                      child: snapshot.data!.isEmpty? ListView(
                                        children: [
                                          Container(child: Center(child: Text('暂无'),),),
                                        ],
                                      ):
                                      ListView.separated(
                                        key: UniqueKey(),
                                        itemBuilder: (BuildContext context, int index) {
                                          return snapshot.data![index];
                                        },
                                        separatorBuilder: (BuildContext context, int index) {
                                          return Divider(height: 1,color: Colors.grey,);
                                        },
                                        itemCount: snapshot.data!.length,
                                      ),
                                    ),
                                  );
                                }else return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                    ),

                    //这是发帖按钮
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: ElevatedButton(
                        onPressed: (){
                          if(Config.token==null||Config.token.length<32)
                            RouterManager.router.navigateTo(context, 'login');
                            else RouterManager.router.navigateTo(context, '/create_new_post');

                          },
                        child:Icon(
                          Icons.add
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(CircleBorder()),
                          minimumSize: MaterialStateProperty.all(Size(80, 80)),//设置按钮大小
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 110,
                      right: 20,
                      child: ElevatedButton(
                        onPressed: (){
                          if(Config.campus=='北洋园'){
                            Config.campus='卫津路';
                          }else Config.campus='北洋园';
                          onRefresh();
                        },
                        child:Config.campus=='北洋园'? Text('北洋园'):Text('卫津路'),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(CircleBorder()),
                          minimumSize: MaterialStateProperty.all(Size(80, 80)),//设置按钮大小
                        ),
                      ),
                    ),


                    ///这是刷新按钮
                    // Positioned(
                    //   bottom: 110,
                    //   right: 20,
                    //   child: ElevatedButton(
                    //     onPressed: (){
                    //       // FormData data = FormData.fromMap({'name':'soap'});
                    //       // var res= await Dio().post('http://101.34.160.18:8888/testservice');
                    //       // print(res.data);
                    //       setState(() {});
                    //       },
                    //     child:Text(
                    //       '刷新',
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //       ),
                    //     ),
                    //     style: ButtonStyle(
                    //       shape: MaterialStateProperty.all(CircleBorder()),
                    //       minimumSize: MaterialStateProperty.all(Size(80, 80)),//设置按钮大小
                    //     ),
                    //   ),
                    // )
                  ]
              ),
            ),
          ],
        )
    );
  }

}