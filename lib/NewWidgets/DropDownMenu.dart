import 'package:flutter/material.dart';
import '../Config.dart';
import '../MapPage.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';

class DropDownMenu extends StatefulWidget{
  final List<String> choices;
  final double width;
  final double height;
  //mapPage传入一个地图
  final mapPage;
  final Function(String?) callbackfunc;
  DropDownMenu ({Key? key, this.height=120, this.width=120, required this.choices, this.mapPage, required this.callbackfunc}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>DropDownMenuState();

}

class DropDownMenuState extends State<DropDownMenu>{


  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        //设置默认值
        value: widget.choices[0],
        // 未来将在这里设置筛选功能
        onChanged: widget.callbackfunc,
        // 传入可选的数组
        items: widget.choices.map((String sex) {
          return DropdownMenuItem(value: sex, child: Text(sex));
        }).toList(),
      ),
    );
  }
}