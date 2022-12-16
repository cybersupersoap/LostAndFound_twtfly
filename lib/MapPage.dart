import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

import 'package:flutter/material.dart';
import 'Config.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_MapPageState();
}

class _MapPageState extends State<MapPage>{
  final AMapWidget map = AMapWidget(
    apiKey: Config.amapApiKeys,
    privacyStatement: Config.amapPrivacyStatement,

  );

  @override
  Widget build(BuildContext context) {
    print('1');
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: map,
    );
  }
}

