import 'package:flutter/material.dart';
import '../Models/InputRecorder.dart';


class NewTextField extends StatefulWidget {
  final int maxLine;
  final int minLine;
  final InputRecorder valueRecorder;
  NewTextField({Key? key, required this.maxLine, required this.minLine,required this.valueRecorder});
  @override
  State<StatefulWidget> createState() {
    return _NewTextFieldState();
  }
}

class _NewTextFieldState extends State<NewTextField> {  @override
  Widget build(BuildContext context) {
    return TextField(
              keyboardType: TextInputType.multiline,
              maxLines: widget.maxLine,
              minLines: widget.minLine,
              onChanged:(value){
                widget.valueRecorder.value=value;
              },
              decoration: const InputDecoration(
                hintText: '输入',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                isDense: true,
                border: const OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    width: 1,
                    style: BorderStyle.none,
                  ),
                ),
              ),
          );
  }
}
