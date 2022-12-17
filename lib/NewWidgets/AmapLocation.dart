import 'dart:async';

import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';

import 'package:permission_handler/permission_handler.dart';

import '../Config.dart';

class AmapLocation{

  late StreamSubscription<Map<String, Object>> locationListener;

  AMapFlutterLocation locationPlugin = new AMapFlutterLocation();


  void requestPermission() async {
    // 申请权限
    Config.hasLocationPermission.value = await requestLocationPermission();
    if (Config.hasLocationPermission.value) {
      if (null != locationPlugin) {
        print("定位权限申请通过,开始定位");
        locationPlugin.startLocation();
      }
    } else {
      print("定位权限申请不通过");
    }
  }

  //开始定位
  void AMapLocationStart() {
    _setLocationOption();
    requestPermission();
    ///注册定位结果监听
  }

  //定位设置
  void _setLocationOption(){
    if (null != locationPlugin) {
      AMapLocationOption locationOption = new AMapLocationOption();

      locationOption.onceLocation = true;

      ///是否需要返回逆地理信息
      locationOption.needAddress = true;//
      locationOption.desiredLocationAccuracyAuthorizationMode =
          AMapLocationAccuracyAuthorizationMode.FullAndReduceAccuracy;

      locationPlugin.setLocationOption(locationOption);
    }
  }

    /// 申请定位权限
    /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
      //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    }
    else {
        //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      }
      else {
        return false;
      }
    }
  }
}