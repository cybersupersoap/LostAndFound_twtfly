import 'package:flutter/material.dart';
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
        title: Text('帖子详情'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: Container(
                      child: Text(
                        post.headline!,
                        style: TextStyle(
                          fontSize: 50,

                           
                        ),
                      ),

                    )
                )
              ],
            )
          )
        ],
      ),
    );
  }
}
