import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:lost_and_found/Models/Post.dart';
import 'package:lost_and_found/main.dart';

import '../Config.dart';
import '../RouterManager.dart';
import 'package:lost_and_found/dio_service.dart';

class MapMarker{
  var latitude;
  var longitude;
  var markerKind;
  var postID;
  MapMarker(this.latitude,this.longitude,this.markerKind,this.postID);
}

class MapMarkers{
  static List<MapMarker> markers=[];
  static void add(double latitude,double longitude,String markerKind,String postID){
    markers.add(MapMarker(latitude,longitude,markerKind,postID));
  }
  static Future<Set<Marker>> generateMarkers(int timeDays) async{
    Posts posts= await DioService.getPosts(1, 100);
    DateTime nowTime=DateTime.now();
    List<Marker> res=[];
    for(int i=0;i<posts.posts.length;i++){
      if(posts.posts[i].latitude==0) continue;
      if(DateTime.tryParse(posts.posts[i].datatime!)?.difference(nowTime).inDays==null||-DateTime.parse(posts.posts[i].datatime!).difference(nowTime).inDays>timeDays) continue;
      final icon = Config.imageMarkerMap[posts.posts[i].itemKind]!=null? 
        await BitmapDescriptor.fromAssetImage(ImageConfiguration(), Config.imageMarkerMap[posts.posts[i].itemKind]!): 
        await BitmapDescriptor.fromAssetImage(ImageConfiguration(), Config.imageMarkerMap['其他']!);
      final marker=Marker(
          position: LatLng(posts.posts[i].latitude!,posts.posts[i].longtitude!),
          icon:icon,
          onTap: (_){
            BuildContext? context=navigatorKey.currentState?.overlay?.context;
            RouterManager.router.navigateTo(context!, '/post?postid=${posts.posts[i].postID}');
          },
      );
      res.add(marker);
    }
    return res.toSet();
  }

}
