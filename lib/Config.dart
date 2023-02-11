import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Models/Post.dart';
import 'Models/InputRecorder.dart';

class Config{
  static bool debugMode=true;
  ///当前位置
  static var nowLatLng;
  static var nowLatitude;
  static var nowLongitude;
  ///当前地图缩放
  static double nowZoom=19.0;
  static var res;
  ///当前位置的地图标记
  static Map<String, Marker> nowLocationMarker={};
  ///是否获取定位权限
  static ValueNotifier<bool> hasLocationPermission=ValueNotifier(false);
  ///当前选择物品种类
  static String nowItem='全部';
  ///当前选择校区
  static String campus='北洋园';
  ///地图mode0中是否选中位置的监听器
  static ValueNotifier<bool> hasChoosePosition=ValueNotifier(false);

  static InputRecorder commentRecorder = InputRecorder();

  static Map<String, AssetImage> imageMap= {
    '钥匙':AssetImage('assets/key.png'),
    '卡片':AssetImage('assets/card.png'),
    '手机':AssetImage('assets/phone.png'),
    '电脑':AssetImage('assets/computer.png'),
    '其他':AssetImage('assets/more.png')
  };

  static Map<String, String> imageMarkerMap= {
    '钥匙':'assets/key_marker.png',
    '卡片':'assets/card_marker.png',
    '手机':'assets/phone_marker.png',
    '电脑':'assets/computer_marker.png',
    '其他':'assets/more_marker.png',
  };

  static Map<String, String> imageMarkerMap2= {
    '钥匙':'assets/key_marker2.png',
    '卡片':'assets/card_marker2.png',
    '手机':'assets/phone_marker2.png',
    '电脑':'assets/computer_marker2.png',
    '其他':'assets/more_marker2.png',
  };



  static const AMapApiKey amapApiKeys = AMapApiKey(
      androidKey: 'd59a37e55dc0a42ee59e4302d92c65b9',
      iosKey: 'd59a37e55dc0a42ee59e4302d92c65b9'
      //iosKey: '您申请的iOS端key'
  );//放置key

  ///北洋园的位置和卫津路的位置
  static const LatLng beiyangyuanLatLng=LatLng(38.997899,117.314542);
  static const LatLng weijinluLatLng=LatLng(39.11019,117.170393);


  static const AMapPrivacyStatement amapPrivacyStatement = AMapPrivacyStatement(
      hasContains: true, hasShow: true, hasAgree: true
  );//隐私协议是否阅读并同意

  static setAmapLocationPrivacyAgree(){
    AMapFlutterLocation.updatePrivacyAgree(true);
    AMapFlutterLocation.updatePrivacyShow(true, true);

}

  static setAmapLocationApiKey(){
    AMapFlutterLocation.setApiKey("d59a37e55dc0a42ee59e4302d92c65b9", "d59a37e55dc0a42ee59e4302d92c65b9");
  }

  static Map<int,Post> posts={};



}
