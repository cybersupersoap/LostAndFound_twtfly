import 'dart:async';

import 'package:dio/dio.dart';
import 'package:lost_and_found/Config.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'Models/Post.dart';
import 'Models/Comment.dart';

class DioService{
  static Future<Posts> getPosts(int i1,int i2)async{
    var response= await Dio().get('http://101.34.160.18:8080/Gsomepost?postid=${i1.toString()}&postid2=${i2.toString()}');
    var posts =Posts.fromJson(response.data);
    return posts;
  }

  static Future<String> addPost({required String itemKind,
  required String headline,
  required String content,
  required String datatime,
  required String LFtype,
  required String latitude,
  required String longtitude,
  required String WorJ}) async{
    var response = await Dio().post('http://101.34.160.18:8080/addpost',data: FormData.fromMap(
      {
        'headline':headline,
        'content':content,
        'latitude':latitude,
        'longitude':longtitude,
        'posttime':datatime,
        'LFtype':LFtype,
        'thingtype':itemKind,
        'WorJ':WorJ,
        'token':Config.token,
      }
    ));
    return response.data;
  }

  static Future<String> addPhotos(AssetEntity photo) async{
    final file = await multipartFileFromAssetEntity(photo);
    var response = await Dio().post('http://101.34.160.18:8080/savepho',data: FormData.fromMap({'file': file}));
    return response.data;
  }

  static Future<List<dynamic>> getPhotos(int postid) async{
    var response =await Dio().get('http://101.34.160.18:8080/Getpho?postid=$postid');
    print(response.data);
    return response.data;
  }

  static Future<MultipartFile> multipartFileFromAssetEntity(AssetEntity entity)async{
    MultipartFile mf;
    final file = await entity.file;
    if (file == null) {
      throw StateError('Unable to obtain file of the entity ${entity.id}.');
    }
    mf= await MultipartFile.fromFile(file.path);
    return mf;
  }

  static Future<void> addComment(int postid,String datetime,String content)async {
    var response = await Dio().post('http://101.34.160.18:8080/addanswer',data: FormData.fromMap({
      'postid':postid,
      'antime':datetime,
      'content':content,
      'token':Config.token
    }));
  }
  static Future<List<Comment>> getComments(int postid) async{
    var response = await Dio().get('http://101.34.160.18:8080/Gsomeanswer?i=${postid}');
    List<Comment> result=[];
    for(int i=0;i<response.data.length;i++){
      result.add(Comment.fromJson(response.data[i]));
    }
    print(result.toString());
    return result.cast<Comment>();
  }

  static Future<List<Post>> searchBySingleKey(String keyWord)async{
    var response = await Dio().get('http://101.34.160.18:8080/Ghebylike1?i=$keyWord');
    var posts = Posts.fromJson(response.data);
    return posts.posts;
  }
  static Future<String> login(String username,String password) async{
    var response =await Dio().get('http://101.34.160.18:8080/Getloginstate?username=$username&password=$password');
    return response.data;
  }
  static Future<String> register(String username ,String password) async{
    var response=await Dio().post('http://101.34.160.18:8080/register',data:FormData.fromMap({'username':username,'password':password}));
    return response.data;
  }
  static Future<String> getUsername(int userid) async{
    var response=await Dio().get('http://101.34.160.18:8080/Gusername?userid=$userid');
    return response.data;
  }

  static Future<int> geticon(int userid) async{
    var response=await Dio().get('http://101.34.160.18:8080/Gicon?userid=$userid');
    return response.data;
  }

}
