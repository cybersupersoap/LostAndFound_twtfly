import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget{
  final List<String> choices;
  DropDownMenu ({Key? key, num height=120, num width=80, required this.choices}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>DropDownMenuState();

}

class DropDownMenuState extends State<DropDownMenu>{

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 120,
      height: 80,
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: 'choices'),
        // 设置默认值
        value: widget.choices[0],
        // 选择回调
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