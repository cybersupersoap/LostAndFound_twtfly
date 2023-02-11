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
    List<Post> posts= await DioService.searchBySingleKey('');
    DateTime nowTime=DateTime.now();
    List<Marker> res=[];
    for(int i=0;i<posts.length;i++){
      if(posts[i].latitude==0) continue;
      if(DateTime.tryParse(posts[i].datatime!)?.difference(nowTime).inDays==null||-DateTime.parse(posts[i].datatime!).difference(nowTime).inDays>timeDays) continue;
      final icon = Config.imageMarkerMap[posts[i].itemKind]!=null?
            (posts[i].LFtype=='拾物'? await BitmapDescriptor.fromAssetImage(ImageConfiguration(), Config.imageMarkerMap[posts[i].itemKind]!): await BitmapDescriptor.fromAssetImage(ImageConfiguration(), Config.imageMarkerMap2[posts[i].itemKind]!)):
            await BitmapDescriptor.fromAssetImage(ImageConfiguration(), Config.imageMarkerMap['其他']!);
      final marker=Marker(
          position: LatLng(posts[i].latitude!,posts[i].longtitude!),
          icon:icon,
          onTap: (_){
            BuildContext? context=navigatorKey.currentState?.overlay?.context;
            RouterManager.router.navigateTo(context!, '/post?postid=${posts[i].postID}');
          },
      );
      res.add(marker);
    }
    return res.toSet();
  }

}
