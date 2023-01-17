import 'package:flutter/material.dart';

class Post{
    String? headline;
    String? content;
    double? latitude;
    double? longtitude;
    DateTime? posttime;
    DateTime? LFtime;
    String? LFtype;
    num? postID;
    String? itemKind;
    String? campus;
    Post.fromJson(Map<String,dynamic> json)
        : this.headline=json['headline'],
          this.content=json['content'],
          this.latitude=json['latitude'],
          this.longtitude=json['longtitude'],
          this.posttime=json['posttime'],
          this.LFtime=json['LFtime'],
          this.LFtype=json['LFtype'],
          this.postID=json['postID'],
          this.itemKind=json['itemKind'],
          this.campus=json['campus'];
    Post.fromTest({headline,content,latitude,longtitude,posttime,LFtime,LFtype,postID,itemKind,campus})
        : this.headline=headline,
          this.content=content,
          this.latitude=latitude,
          this.longtitude=longtitude,
          this.posttime=posttime,
          this.LFtime=LFtime,
          this.LFtype=LFtype,
          this.postID=postID,
          this.itemKind=itemKind,
          this.campus=campus;
}
