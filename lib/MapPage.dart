import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';

import 'package:flutter/material.dart';
import 'package:lost_and_found/Models/MapMarker.dart';
import 'package:lost_and_found/RouterManager.dart';
import 'package:lost_and_found/TestFile.dart';
import 'Config.dart';
import 'NewWidgets/AmapLocation.dart';
import 'NewWidgets/DropDownMenu.dart';
import 'Regeo.dart';

import 'package:permission_handler/permission_handler.dart';



class MapPage extends StatefulWidget {
  ///地图有三种模式
  ///当mode为0时，是失物地图模式，该模式下会展示当前所有的失物
  ///当mode为1时，是定位模式，该模式下不会展示任何失物，但是允许用户选择位置
  ///当mode为2是，是展示位置模式，该模式下会展示一个失物的位置
  final String mode;
  var initLatitude;
  var initLongitude;

  MapPage({Key? key, required this.mode,this.initLatitude,this.initLongitude});

  @override
  State<StatefulWidget> createState() =>_MapPageState();
}

class _MapPageState extends State<MapPage>{
  late Map<String, Object> _locationResult;
  late AMapController _mapController;
  var map;
  var locRes;
  //地图初始化
  void _onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  //改变镜头位置
   void changeCameraPosition(LatLng position) {
    _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: Config.nowZoom),
      ),
      animated: true,
    );
  }
  //记录镜头位置并绘制marker
  void _onCameraMoveEnd(CameraPosition cameraPosition){
    setState(() {
      Config.nowLocationMarker['now']=Marker(
          position: cameraPosition.target,
      );
      Config.nowLatLng=cameraPosition.target;
      Config.nowLatitude=cameraPosition.target.latitude;
      Config.nowLongitude=cameraPosition.target.longitude;
      Config.nowZoom=cameraPosition.zoom;
    });
    print(Config.nowLatLng);
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
          Config.nowLongitude=longitude;
          Config.nowLatitude=latitude;
          print(_locationResult);
          locRes=_locationResult;
          changeCameraPosition(LatLng(latitude, longitude));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    ///futurebuilder使用参考于https://qa.1r1g.com/sf/ask/3938206961/
    map = FutureBuilder(
      future: MapMarkers.generateMarkers(MapMarkers.markers),
      initialData: Set.of(<Marker>[]),
      builder: (context,snapshot)=>AMapWidget(
        apiKey: Config.amapApiKeys,
        privacyStatement: Config.amapPrivacyStatement,
        onMapCreated: _onMapCreated,
        initialCameraPosition: widget.mode=='2'? CameraPosition(target: LatLng(widget.initLatitude,widget.initLongitude),zoom: Config.nowZoom) :Config.nowLatLng==null? (Config.campus=='北洋园'? CameraPosition(target: Config.beiyangyuanLatLng, zoom: Config.nowZoom): CameraPosition(target: Config.weijinluLatLng, zoom: Config.nowZoom)):  CameraPosition(target: Config.nowLatLng, zoom: Config.nowZoom),
        ///地图marker
        markers: widget.mode=='1'? Set<Marker>.of(Config.nowLocationMarker.values):
                widget.mode=='0' ? snapshot.data!: 
                widget.mode=='2'? Set<Marker>.of([Marker(position: LatLng(widget.initLatitude,widget.initLongitude))]) : Set<Marker>.of([]),
        onCameraMoveEnd: _onCameraMoveEnd,
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          map,

          ///一个在地图中心的点，用来辅助瞄准
          widget.mode=='1'? Center(
            child: Icon(
              Icons.circle,
              color: Colors.blue,
              size: 5,
            ),
          ):
          Container(),

          ///改变校区下拉选单,在模式不为展示位置模式时显示
          widget.mode!='2'? Positioned(
            top:20,
            left: 20,
            child: DropDownMenu(
              choices: [
                '北洋园',
                '卫津路',
              ],
              func: 'changeCampus',
              mapPage: this,
            ),
          ):Container(),

          ///定位按钮,在模式不为展示位置模式时显示
          widget.mode!='2'? Positioned(
            top: 20,
            right: 20,
            child: ElevatedButton(
                onPressed: getPosition,

                ///利用ValueListenableBuilder监听是否获取权限，获取权限后立刻改变按钮文字
                child: ValueListenableBuilder(
                  valueListenable: Config.hasLocationPermission,
                  builder: (context,value,child){
                    return Config.hasLocationPermission.value?
                    Text('定位'):Text('获取权限');
                  },
                  child: Config.hasLocationPermission.value?
                    Text('定位'):Text('获取权限'),
                )
            ),
          ):Container(),

          widget.mode=='1'? Align(
            alignment: Alignment(0,0.9),
            child: ElevatedButton(
              child: Text('选择该位置'),
              onPressed: (){
                Config.hasChoosePosition.value=true;
                RouterManager.router.pop(context);
              },
            ),
          ):Container(),

          widget.mode=='2'? Align(
            alignment: Alignment(0,0.9),
            child: ElevatedButton(
              child: Text('返回'),
              onPressed: (){
                RouterManager.router.pop(context);
              },
            ),
          ):Container(),
          
          // Positioned(
          //     bottom: 20,
          //     left: 20,
          //     child: ElevatedButton(
          //       child: Text('regeotest'),
          //       onPressed: (){
          //         Regeo.regeo(Config.nowLatitude, Config.nowLongitude);
          //         setState(() {
          //         });
          //       },
          //     )
          // ),
          // Config.debugMode? Positioned(
          //     top:80,
          //     right:50,
          //     child: locRes==null? Container():Container(height:1000,width:300,child: Text(locRes.toString())),
          // ):Container(),

        ],
      ),
    );
  }
}

