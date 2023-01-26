import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Config{
  //当前位置
  static var nowLatLng;

  static var nowLatitude;

  static var nowLongitude;
  //当前地图缩放
  static double nowZoom=19.0;

  static var res;
  //当前位置的地图标记
  static Map<String, Marker> nowLocationMarker={};
  //其他地图标记，暂时没用，未来会用上，用于显示失物位置
  static var markers;
  //是否获取定位权限
  static ValueNotifier<bool> hasLocationPermission=ValueNotifier(false);
  //当前选择物品种类
  static String nowItem='全部';
  //当前选择校区
  static String campus='北洋园';

  static Map<String, AssetImage> imageMap= {
    '钥匙':AssetImage('assets/key.png'),
    '卡片':AssetImage('assets/card.png'),
    '手机':AssetImage('assets/phone.png'),
    '电脑':AssetImage('assets/computer.png')
  };

  static const AMapApiKey amapApiKeys = AMapApiKey(
      androidKey: 'd59a37e55dc0a42ee59e4302d92c65b9',
      iosKey: 'd59a37e55dc0a42ee59e4302d92c65b9'
      //iosKey: '您申请的iOS端key'
  );//放置key

  //北洋园的位置和卫津路的位置
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



}
