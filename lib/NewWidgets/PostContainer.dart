import 'package:flutter/material.dart';
import '../Models/Post.dart';
import '../Config.dart';

class PostContainer extends StatelessWidget{
  final double height;
  final Post post;
  PostContainer({Key? key, this.height=90,required this.post}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: ListTile(
          leading: Container(
            height: height-20,
            width: height-20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: Config.imageMap[post.itemKind]!,
                fit: BoxFit.fill,
              ),
            ),
          ),
          title: Text(post.headline!),
          subtitle: Text(post.content!,overflow: TextOverflow.ellipsis,),
          isThreeLine: false,
          trailing: Text(post.posttime.toString().substring(0,16)),

        ),
      ),
      onTap: (){

      },
    );
  }

}