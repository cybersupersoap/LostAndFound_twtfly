import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/CreateCommentPage.dart';
import 'package:lost_and_found/MapPage.dart';

import 'Config.dart';
import 'CreatePostPage.dart';
import 'MyHomePage.dart';
import 'PostPage.dart';
import 'myinformation/pages/MyMessage.dart';
import 'myinformation/pages/MySuccess.dart';
import 'myinformation/pages/NickName.dart';

class RouterManager {
  static final router = FluroRouter();

  ///主页
  static String homePagePath = '/home';
  static var homePageHandler = Handler(
      handlerFunc: (BuildContext? ct, Map<String, List<String>> params) {
    return MyHomePage();
  });

  ///地图界面
  ///地图有三种模式
  ///当mode为0时，是失物地图模式，该模式下会展示当前所有的失物
  ///当mode为1时，是定位模式，该模式下不会展示任何失物，但是允许用户选择位置
  ///当mode为2是，是展示位置模式，该模式下会展示一个失物的位置
  static String mapPagePath = '/map';
  static var mapPageHandler = Handler(
      handlerFunc: (BuildContext? ct, Map<String, List<String>> params) {
    var mode = params['mode']?.first;
    if (params['latitude'] != null) {
      return MapPage(
          mode: mode!,
          initLatitude: double.parse(params['latitude']!.first),
          initLongitude: double.parse(params['longitude']!.first));
    } else
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

  ///发布新帖界面
  static String createPostPagePath = '/create_new_post';
  static var createPostPageHandler = Handler(
      handlerFunc: (BuildContext? ct, Map<String, List<String>> params) {
    return CreatePostPage();
  });

  static String mysuccessPage = '/my_success';
  static var mysuccessPageHandler = Handler(
      handlerFunc: (BuildContext? ct, Map<String, List<String>> params) {
    return MySimpleSuccessPage();
  });

  ///帖子详情
  static String postPage = '/post';
  static var postPageHandler = Handler(
      handlerFunc: (BuildContext? ct, Map<String, List<String>> params) {
    var postid = params['postid']?.first;
    return PostPage(post: Config.posts[int.parse(postid!)]!);
  });

  ///发表回复
  static String createCommentPage = '/create_new_comment';
  static var createCommentPageHandler = Handler(
      handlerFunc: (BuildContext? ct, Map<String, List<String>> params) {
    var postid = params['postid']?.first;
    return CreateCommentPage(postid: int.parse(postid!));
  });

  static void DefineRoutes() {
    router.define(homePagePath, handler: homePageHandler);
    router.define(mapPagePath, handler: mapPageHandler);
    router.define(nicknamePage, handler: nicknamePageHandler);
    router.define(createPostPagePath, handler: createPostPageHandler);
    router.define(mymessagePage, handler: mymessagePageHandler);
    router.define(mysuccessPage, handler: mysuccessPageHandler);
    router.define(postPage, handler: postPageHandler);
    router.define(createCommentPage, handler: createCommentPageHandler);
  }
}
