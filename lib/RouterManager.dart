import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/MapPage.dart';

import 'MyHomePage.dart';
import 'myinformation/pages/MyMessage.dart';
import 'myinformation/pages/MySuccess.dart';
import 'myinformation/pages/NickName.dart';

class RouterManager {
  static final router = FluroRouter();
  //主页
  static String homePagePath = '/home';
  static var homePageHandler = Handler(
      handlerFunc: (BuildContext? ct, Map<String, List<String>> params) {
    return MyHomePage();
  });

  static String mapPagePath = '/map';
  static var mapPageHandler = Handler(
      handlerFunc: (BuildContext? ct, Map<String, List<String>> params) {
    var mode = params['mode']?.first;
    return MapPage(mode: mode!);
  });

  static String nicknamePage = '/change_name';
  static var nicknamePageHandler = Handler(
      handlerFunc: (BuildContext? ct, Map<String, List<String>> params) {
    return NickNamePage();
  });

  static String mymessagePage = '/my_message';
  static var mymessagePageHandler = Handler(
      handlerFunc: (BuildContext? ct, Map<String, List<String>> params) {
    return MyMessagePage();
  });

  static String mysuccessPage = '/my_success';
  static var mysuccessPageHandler = Handler(
      handlerFunc: (BuildContext? ct, Map<String, List<String>> params) {
    return MySuccessPage();
  });

  static void DefineRoutes() {
    router.define(homePagePath, handler: homePageHandler);
    router.define(mapPagePath, handler: mapPageHandler);
    router.define(nicknamePage, handler: nicknamePageHandler);
    router.define(mymessagePage, handler: mymessagePageHandler);
    router.define(mysuccessPage, handler: mysuccessPageHandler);
  }
}
