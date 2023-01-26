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
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            RouterManager.router.pop(context);
          },
        ),
        title: Text('帖子详情'),
      ),

    );
  }
}
