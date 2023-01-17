import 'package:flutter/material.dart';
import 'Models/Post.dart';
import 'NewWidgets/PostContainer.dart';

class TestFile{
  static List<PostContainer> postlist=[];
  static void add(Post post){
    postlist.add(PostContainer(post: post));
  }

}