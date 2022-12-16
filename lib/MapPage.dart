import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';

import 'package:flutter/material.dart';
import 'Config.dart';
import 'NewWidgets/AmapLocation.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_MapPageState();
}

class _MapPageState extends State<MapPage>{
  late Map<String, Object> _locationResult;
  late AMapController _mapController;
  var map;

  //新建地图
  @override
  void initState() {
    map = AMapWidget(
      apiKey: Config.amapApiKeys,
      privacyStatement: Config.amapPrivacyStatement,
      onMapCreated: _onMapCreated,
    );

  }

  //地图初始化
  void _onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  //改变地图中心，目前没有动画
  void _changeCameraPosition(LatLng position) {
    _mapController?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 30),
      ),
      animated: true,
    );
  }

  //获得位置并改变镜头位置
  void getPosition(){
    Config.setAmapLocationApiKey();
    Config.setAmapLocationPrivacyAgree();
    AmapLocation amapLocation=new AmapLocation();
    amapLocation.AMapLocationStart();
    var location=amapLocation;
    location.locationListener = location.locationPlugin.onLocationChanged().listen((Map<String, Object> result) {
      setState(() {
        print(result);
        _locationResult = result;
        if (_locationResult != null) {
          double longitude = double.tryParse(_locationResult['longitude'].toString())!;
          double latitude = double.tryParse(_locationResult['latitude'].toString())!;

          print('当前位置：longitude：$longitude,latitude:$latitude');

          _changeCameraPosition(LatLng(latitude!, longitude!));
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        map,
        Positioned(
          top: 20,
          right: 20,
          child: ElevatedButton(
              onPressed: getPosition,
              child: Text(
                '定位',
              )
          ),
        )
      ],
    );
  }
}

