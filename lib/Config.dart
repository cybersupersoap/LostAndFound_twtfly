import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
class Config{
  static const AMapApiKey amapApiKeys = AMapApiKey(
      androidKey: 'd59a37e55dc0a42ee59e4302d92c65b9',
      iosKey: 'd59a37e55dc0a42ee59e4302d92c65b9'
      //iosKey: '您申请的iOS端key'
  );//放置key

  static const AMapPrivacyStatement amapPrivacyStatement = AMapPrivacyStatement(
      hasContains: true, hasShow: true, hasAgree: true
  );//隐私协议是否阅读并同意
}
