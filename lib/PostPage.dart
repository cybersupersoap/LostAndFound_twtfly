import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'RouterManager.dart';
import 'Models/Post.dart';

class PostPage extends StatelessWidget {
  final Post post;
  PostPage({Key? key,required this.post}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back,
              color: Colors.blueGrey,
          ),
          onPressed: (){
            RouterManager.router.pop(context);
          },
        ),
        title: Text(
            '帖子详情',
          style: TextStyle(
            color: Colors.blueGrey,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsetsDirectional.only(top:10)),
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Icon(Icons.person,size: 40,),
                              padding: EdgeInsets.all(10),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(padding: EdgeInsetsDirectional.only(top: 10)),
                                Text('testuser'),
                                Text(post.datatime!.substring(0,19)),
                              ],
                            )
                          ],
                        )
                    ),
                    Positioned(
                      right: 1,
                        child: GestureDetector(
                              child: Container(
                                padding: EdgeInsetsDirectional.only(top:10,end: 20),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      post.WorJ!,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    post.latitude!=0? Icon(Icons.place_outlined,color: Colors.blue,):Container(),
                                  ],
                                ),
                              ),
                              onTap: ()=>post.latitude!=0? RouterManager.router.navigateTo(context, '/map?mode=2&latitude=${post.latitude}&longitude=${post.longtitude}'):null,
                            )
                    ),
                ]
                ),
              ),
              Container(
                padding: EdgeInsetsDirectional.only(start: 10,top: 10),
                child: Text(
                  post.headline!,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              post.content!='null'?
                  Container(
                    padding: EdgeInsetsDirectional.only(top:15,start: 10),
                    child: Text(
                        post.content!,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ):Container(),

              Column(
                children: post.photos!.map((photo)=>Container(
                    padding: EdgeInsetsDirectional.all(10),
                    child: Image(
                      image: AssetEntityImageProvider(photo),
                      fit: BoxFit.fitWidth,
                    )
                )
                ).toList(),
              ),

              Padding(padding: EdgeInsetsDirectional.only(top:20)),

              Divider(
                thickness: 2,
              )
            ],
          ),
        ]
      ),
    );
  }
}
