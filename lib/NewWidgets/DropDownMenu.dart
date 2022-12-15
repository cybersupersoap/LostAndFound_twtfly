import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget{
  final List<String> choices;
  final double width;
  final double height;
  DropDownMenu ({Key? key, this.height=120, this.width=120, required this.choices}) : super(key: key);

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
        // decoration: const InputDecoration(
        //     border: OutlineInputBorder(), labelText: 'choices'),//美化部件，感觉也不算好看
        //设置默认值
        value: widget.choices[0],
        // 未来将在这里设置筛选功能
        onChanged: (String? newPosition) {
          print('$newPosition');
          setState(() {});
        },
        // 传入可选的数组
        items: widget.choices.map((String sex) {
          return DropdownMenuItem(value: sex, child: Text(sex));
        }).toList(),
      ),
    );
  }
}