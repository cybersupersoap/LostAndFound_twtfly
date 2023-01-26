import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:core_location_fluttify/core_location_fluttify.dart';
import 'package:dio/dio.dart';
import 'package:lost_and_found/Config.dart';

class Regeo{
  static void regeo(double latitude,double longitude) async{
    //final regeocode= await AmapSearch.instance.searchReGeocode(LatLng(latitude, longitude),radius: 200.0);
    var res=await Dio().get('https://restapi.amap.com/v3/geocode/regeo?output=json&location=$longitude,$latitude&key=a8f0c13dd0c585c33f1e1f8f269faab6&radius=50 &extensions=all');
    print(longitude);
    print(latitude);
    Config.res=res.data['regeocode']['pois'].toString();
    print(res);
  }
}
