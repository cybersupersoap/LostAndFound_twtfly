import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class Post{
    String? headline;
    String? content;
    double? latitude;
    double? longtitude;
    String? datatime;
    String? LFtype;
    num? postID;
    String? itemKind;
    String? WorJ;
    List<AssetEntity>? photos;
    Post.fromJson(Map<String,dynamic> json)
        : this.headline=json['headline'],
          this.content=json['content'],
          this.latitude=json['latitude'],
          this.longtitude=json['longtitude'],
          this.datatime=json['datatime'],
          this.LFtype=json['LFtype'],
          this.postID=json['postID'],
          this.itemKind=json['itemKind'],
          this.WorJ=json['WorJ'],
          this.photos=json['photos'];
    Post.fromTest({headline,content,latitude,longtitude,datatime,LFtime,LFtype,postID,itemKind,WorJ,photos})
        : this.headline=headline,
          this.content=content,
          this.latitude=latitude,
          this.longtitude=longtitude,
          this.datatime=datatime,
          this.LFtype=LFtype,
          this.postID=postID,
          this.itemKind=itemKind,
          this.WorJ=WorJ,
          this.photos=photos;
}
