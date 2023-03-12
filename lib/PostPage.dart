import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'Config.dart';
import 'RouterManager.dart';
import 'dio_service.dart';
import 'Models/Post.dart';
import 'Models/Comment.dart';

class PostPage extends StatefulWidget {
  final Post post;
  PostPage({Key? key,required this.post}) : super(key:key);
  @override
  State<StatefulWidget> createState() => _PostPageState();
}
class _PostPageState extends State<PostPage> {
  var url;
  var comments;
  var lzUsername;
  var lzIcon;
  List<String> commentUsername=[];
  List<int> commentIcon=[];

  Future<void> onRefresh() async {
    url=await DioService.getPhotos(widget.post.postID!);
    if(widget.post.userid!=null){
      lzUsername=Future.value(await DioService.getUsername(widget.post.userid!));
      lzIcon=Future.value(await DioService.geticon(widget.post.userid!));
    }
    else {
      lzUsername='获取用户名失败';
      lzIcon=AssetImage('assets/more.png');
    }
    comments=await DioService.getComments(widget.post.postID!);
    for(int i=0;i<comments.length;i++){
      if(comments[i].userid!=null){
        String a=await DioService.getUsername(comments[i].userid!);
        int b=await DioService.geticon(comments[i].userid!);
        commentUsername.add(a);commentIcon.add(b);
      }
      else {
        commentUsername.add('获取用户名失败');commentIcon.add(1);
      }
    }
    setState(()  {
    });
  }

  @override
  void initState() {
    super.initState();
    onRefresh();
  }


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
            '帖子详情 ${widget.post.postID}',
          style: TextStyle(
            color: Colors.blueGrey,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Stack(
          children: <Widget>[
            ListView(
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
                                        width: 55,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(150)
                                        ),
                                        child: FutureBuilder(
                                          future: lzIcon,
                                          builder: (context, snapshot) {
                                            if(snapshot.connectionState==ConnectionState.done)
                                            return Image(
                                              image: Config.imageMap2[snapshot.data]!,
                                              fit: BoxFit.fitWidth
                                            );
                                            else return Container();
                                          }
                                        ),
                                        padding: EdgeInsets.all(10),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(padding: EdgeInsetsDirectional.only(top: 10)),
                                          FutureBuilder(
                                            future: lzUsername,
                                            builder: (context, snapshot) {
                                              if(snapshot.connectionState==ConnectionState.done)
                                              return Text(snapshot.data.toString());
                                              else return Text('加载中');
                                            }
                                          ),
                                          widget.post.datatime!.length<19? Text(widget.post.datatime!): Text(widget.post.datatime!.substring(0,19)),
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
                                            widget.post.WorJ!,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          widget.post.latitude!=0? Icon(Icons.place_outlined,color: Colors.blue,):Container(),
                                        ],
                                      ),
                                    ),
                                    onTap: ()=>widget.post.latitude!=0? RouterManager.router.navigateTo(context, '/map?mode=2&latitude=${widget.post.latitude}&longitude=${widget.post.longtitude}'):null,
                                  )
                              ),
                            ]
                        ),
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.only(start: 10,top: 10),
                        child: Text(
                          widget.post.headline!,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      widget.post.content!='null'?
                      Container(
                        padding: EdgeInsetsDirectional.only(top:15,start: 10),
                        child: Text(
                          widget.post.content!,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ):Container(),

                      if(url!=null)Column(
                        children: url.map<Container>((photo)=>Container(
                            padding: EdgeInsetsDirectional.all(10),
                            child: Image.network(
                              "http://101.34.160.18:8080/savepho/${photo}",
                              loadingBuilder: (context,child,loadingProgress){
                                if(loadingProgress==null) return child;
                                return Container(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(
                                    value: loadingProgress!=null ? loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                        : null :null,
                                  ),
                                );
                              },
                              fit: BoxFit.fitWidth,
                            )
                        )
                        ).toList(),
                      ),

                      Padding(padding: EdgeInsetsDirectional.only(top:20)),

                      Divider(
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      if(comments!=null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: comments.asMap().keys.map<CommentContainer>(
                            (i){
                              return CommentContainer(comment: comments[i],username:commentUsername[i],icon:commentIcon[i]);
                            }
                        ).toList(),
                      ),
                      Container(
                        height: 100,
                        child: Center(child: Text('没有更多了',style: TextStyle(color: Colors.blueGrey),)),
                      )
                    ],
                  ),
                ]
            ),

            Positioned(
              bottom: 5,
              right: 5,
              child: ElevatedButton(
                onPressed: (){
                  if(Config.token==null||Config.token.length<32)
                  RouterManager.router.navigateTo(context, 'login');
                  else RouterManager.router.navigateTo(context, '/create_new_comment?postid=${widget.post.postID}');
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
          ]
        ),
      ),
    );
  }
}

class CommentContainer extends StatelessWidget {
  Comment comment;
  String username;
  int icon;
  CommentContainer({Key? key,required this.comment,required this.username,required this.icon}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150)
                ),
                child: Image(
                  image: Config.imageMap2[icon]!,
                  fit: BoxFit.fitWidth,
                ),
                padding: EdgeInsets.all(10),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsetsDirectional.only(top: 10)),
                  Text(username),
                  comment.date.length<19? Text(comment.date): Text(comment.date.substring(0,19)),
                ],
              )
            ],
          ),
          Container(
            padding: EdgeInsetsDirectional.only(start: 10),
            child: Text(
              comment.content,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Padding(padding: EdgeInsetsDirectional.only(top:10)),
          Divider(thickness: 2, indent:20 ,endIndent: 20,)
        ]
      ),
    );
  }
}
