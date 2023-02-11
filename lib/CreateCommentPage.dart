import 'package:flutter/material.dart';
import 'package:lost_and_found/Config.dart';
import 'package:lost_and_found/RouterManager.dart';
import 'package:lost_and_found/dio_service.dart';
import 'NewWidgets/NewTextField.dart';

class CreateCommentPage extends StatefulWidget {
  int postid;
  CreateCommentPage({Key? key,required this.postid}) : super(key:key);
  @override
  State<StatefulWidget> createState() {
    Config.commentRecorder.value='';
    return _CreateCommentPageState();
  }
}

class _CreateCommentPageState extends State<CreateCommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('回复',style: TextStyle(color: Colors.blueGrey),),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            RouterManager.router.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.blueGrey,),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsetsDirectional.all(10),
            child: NewTextField(maxLine: 5,minLine: 5, valueRecorder: Config.commentRecorder),
          ),
          ElevatedButton(
              onPressed:()async{
                RouterManager.router.pop(context);
                await DioService.addComment(widget.postid, DateTime.now().toString(), Config.commentRecorder.value);
              },
              child:Text('提交'),
          )
        ],
      ),
    );
  }
}
