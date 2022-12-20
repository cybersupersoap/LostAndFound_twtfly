import 'package:flutter/material.dart';
import '../Config.dart';
import '../MapPage.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';

class DropDownMenu extends StatefulWidget{
  final List<String> choices;
  final double width;
  final double height;
  final String func;
  //mapPage传入一个地图
  final mapPage;
  DropDownMenu ({Key? key, this.height=120, this.width=120, required this.choices, required this.func, this.mapPage}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>DropDownMenuState();

}

class DropDownMenuState extends State<DropDownMenu>{

  //这是物品种类下拉栏调用的onchange
  void ChangeItemKind(String? item){
    Config.nowItem=item!;
    setState(() {});
  }

  //这是校区下拉栏调用的onchange
  void ChangeCampus(String? campus){
    Config.campus=campus!;
    if(widget.mapPage!=null)widget.mapPage.changeCameraPosition(campus=='北洋园'? Config.beiyangyuanLatLng:Config.weijinluLatLng,);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: DropdownButtonFormField<String>(
        isExpanded: true,

        //设置默认值
        value: widget.func=='changeCampus'? Config.campus:widget.choices[0],
        // 未来将在这里设置筛选功能
        onChanged: widget.func=='changeItemKind'? ChangeItemKind:ChangeCampus,
        // 传入可选的数组
        items: widget.choices.map((String sex) {
          return DropdownMenuItem(value: sex, child: Text(sex));
        }).toList(),
      ),
    );
  }
}