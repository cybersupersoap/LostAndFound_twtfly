import 'package:flutter/material.dart';
import 'Models/Post.dart';
import 'NewWidgets/PostContainer.dart';

class TestFile{
  static List<PostContainer> postlist=[];
  static void add(Post post){
    post.postID=postlist.length;
    postlist.add(PostContainer(post: post));
  }
  static List search(String kind){
    List<PostContainer> res=[];
    for(int i=0;i<postlist.length;i++){
      if(kind==postlist[i].post.LFtype||kind==postlist[i].post.postID.toString()){
        res.add(postlist[i]);
      }
    }
    return res;
  }

}