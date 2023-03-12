import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../Config.dart';

class Post{
    String? headline;
    String? content;
    double? latitude;
    double? longtitude;
    String? datatime;
    String? LFtype;
    int? postID;
    String? itemKind;
    String? WorJ;
    int? userid;
    Post.fromJson(Map<String,dynamic> json)
        : this.headline=json['headline'],
          this.content=json['content'],
          this.latitude=double.parse(json['latitude']),
          this.longtitude=double.parse(json['longitude']),
          this.datatime=json['posttime'],
          this.LFtype=json['lftype'],
          this.postID=json['postid'],
          this.itemKind=json['thingtype'],
          this.WorJ=json['worJ'],
          this.userid=json['userid']{
    }
    Post.fromTest({headline,content,latitude,longtitude,datatime,LFtime,LFtype,postID,itemKind,WorJ})
        : this.headline=headline,
          this.content=content,
          this.latitude=latitude,
          this.longtitude=longtitude,
          this.datatime=datatime,
          this.LFtype=LFtype,
          this.postID=postID,
          this.itemKind=itemKind,
          this.WorJ=WorJ;
}
class Posts {
    final List<Post> posts;

    Posts.fromJson(List<dynamic> json)
        :this.posts =
            List<Post>.from(json.map((x) {
                Config.posts.addAll(<int,Post>{x['postid']:Post.fromJson(x)});
                return Post.fromJson(x);
            }));
}