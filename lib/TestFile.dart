import 'package:flutter/material.dart';
import 'Models/Post.dart';
import 'NewWidgets/PostContainer.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:lost_and_found/Models/MapMarker.dart';

class TestFile{
  static List<PostContainer> postlist=[];
  static List<Marker> markerlist=[];

  ///临时数据添加，后端怎么还没搞好服务器
  static void add(Post post) async {
    post.postID=postlist.length;
    postlist.add(PostContainer(post: post));
    if(post.latitude!=null){
      MapMarkers.add(post.latitude!, post.longtitude!, post.itemKind! ,post.postID.toString()!);
    }
  }

  ///临时搜索，后端怎么还没搞好服务器
  static List search(List<String> kind){
    List<PostContainer> res=[];
    for(int i=0;i<postlist.length;i++){
      bool flag = true;
      for(int j=0;j<kind.length;j++) {
        if (!(kind[j] == postlist[i].post.LFtype ||
            kind[j] == postlist[i].post.postID.toString() ||
            kind[j] == postlist[i].post.itemKind
        )) {
          flag = false;
        }
      }
      if (flag) res.add(postlist[i]);
    }
    return res;
  }



}