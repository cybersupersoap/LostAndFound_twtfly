import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
class Config{
  //当前位置
  static var nowLatLng;
  //当前位置的地图标记
  static Map<String, Marker> nowLocationMarker={};
  //其他地图标记，暂时没用，未来会用上，用于显示失物位置
  static var markers;

  static const AMapApiKey amapApiKeys = AMapApiKey(
      androidKey: 'd59a37e55dc0a42ee59e4302d92c65b9',
      iosKey: 'd59a37e55dc0a42ee59e4302d92c65b9'
      //iosKey: '您申请的iOS端key'
  );//放置key

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
