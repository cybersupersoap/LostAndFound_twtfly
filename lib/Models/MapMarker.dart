import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:lost_and_found/main.dart';

import '../Config.dart';
import '../RouterManager.dart';

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
  static Future<Set<Marker>> generateMarkers(List<MapMarker> markerlist) async{
    List<Marker> res=[];
    for(final amarker in markerlist){
      final icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), Config.imageMarkerMap[amarker.markerKind]!);
      final marker=Marker(
          position: LatLng(amarker.latitude,amarker.longitude),
          icon:icon,
          onTap: (_){
            BuildContext? context=navigatorKey.currentState?.overlay?.context;
            RouterManager.router.navigateTo(context!, '/post?postid=${amarker.postID}');
          },
      );
      res.add(marker);
    }
    return res.toSet();
  }

}
