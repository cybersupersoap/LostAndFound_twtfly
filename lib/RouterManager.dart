import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/MapPage.dart';
import 'MyHomePage.dart';


class RouterManager{

  static final router=FluroRouter();
  //主页
  static String homePagePath= '/home';
  static var homePageHandler=
      Handler(handlerFunc: (BuildContext? ct,Map<String,List<String>> params){
        return MyHomePage();
      });

  static String mapPagePath='/map';
  static var mapPageHandler=
      Handler(handlerFunc: (BuildContext? ct,Map<String,List<String>> params){
        var mode=params['mode']?.first;
        return MapPage(mode: mode!);
      });


  static void DefineRoutes(){
    router.define(homePagePath,handler: homePageHandler );
    router.define(mapPagePath,handler: mapPageHandler);
  }
}