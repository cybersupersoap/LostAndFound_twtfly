import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import 'RouterManager.dart';
import 'NewWidgets/NewTextField.dart';
import 'Models/InputRecorder.dart';
import 'Models/Post.dart';
import 'Models/MapMarker.dart';
import 'Config.dart';

import 'TestFile.dart';
import 'dio_service.dart';

class CreatePostPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    ///初始化一下位置选择状态
    Config.hasChoosePosition.value=false;

    return _CreatePostPageState();
  }
}

class _CreatePostPageState extends State<CreatePostPage> {
  var isLost=true;
  var isBeiyangyuan=true;
  var postDescription='';
  var chosenOne='卡片';
  var postContentRecorder= InputRecorder();
  List<AssetEntity> photos=[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blueGrey,
          ),
          onPressed: (){
            RouterManager.router.pop(context);
          },
        ),
        title: Text(
          '发帖',
          style: TextStyle(

          ),
        ),
      ),

      body: Container(
        padding: EdgeInsetsDirectional.only(start: 10),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsetsDirectional.only(top:10)),
                Container(
                  padding: EdgeInsetsDirectional.only(end:10),
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '请选择发帖类型',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 20,
                            ),
                          ),
                          Padding(padding: EdgeInsetsDirectional.only(top: 10)),
                          ///选择失物拾物
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isLost=true;
                                  });
                                },
                                child: Container(
                                  width: 80,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      '失物',
                                      style: TextStyle(
                                          color: isLost==true? Colors.white : Colors.blue,
                                          fontSize: 20
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: isLost==true? Colors.blue : Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsetsDirectional.only(start: 10)),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isLost=false;
                                  });
                                },
                                child: Container(
                                  width: 80,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      '拾物',
                                      style: TextStyle(
                                          color: isLost==true? Colors.blue : Colors.white,
                                          fontSize: 20
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: isLost==true? Colors.white : Colors.blue,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        right: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '请选择校区',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 20,
                              ),
                            ),
                            Padding(padding: EdgeInsetsDirectional.only(top: 10)),

                            ///选择校区
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      isBeiyangyuan=true;
                                    });
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        '北洋园',
                                        style: TextStyle(
                                            color: isBeiyangyuan==true? Colors.white : Colors.blue,
                                            fontSize: 20
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: isBeiyangyuan==true? Colors.blue : Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsetsDirectional.only(start: 10)),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      isBeiyangyuan=false;
                                    });
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        '卫津路',
                                        style: TextStyle(
                                            color: isBeiyangyuan==true? Colors.blue : Colors.white,
                                            fontSize: 20
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: isBeiyangyuan==true? Colors.white : Colors.blue,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                Padding(padding: EdgeInsetsDirectional.only(top:10)),

                Text(
                  '请简单描述物品',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20,
                  ),
                ),

                ///输入物品描述
                Container(
                  padding: EdgeInsetsDirectional.only(end:50),
                  child: TextField(
                    onChanged: (value){setState(() {
                      postDescription = value;
                    });},
                    decoration: InputDecoration(
                      counterText: '${postDescription.length}/50',
                    ),
                  ),
                ),

                Text(
                  '请选择物品类型',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20,
                  ),
                ),

                ///选择物品类型
                Row(
                  children: <Widget>[
                    GestureDetector(
                      child: ItemKind(
                        imagePath: 'assets/card.png',
                        name: '卡片',
                        isChosen: chosenOne,
                      ),
                      onTap: (){
                        setState(() {
                          chosenOne='卡片';
                        });
                      },
                    ),
                    Padding(padding: EdgeInsetsDirectional.only(end: 15)),
                    GestureDetector(
                      child: ItemKind(
                          imagePath: 'assets/key.png',
                          name: '钥匙',
                          isChosen: chosenOne,
                      ),
                      onTap: (){
                        setState(() {
                          chosenOne='钥匙';
                        });
                      },
                    ),
                    Padding(padding: EdgeInsetsDirectional.only(end: 15)),
                    GestureDetector(
                      child: ItemKind(
                          imagePath: 'assets/phone.png',
                          name: '手机',
                          isChosen: chosenOne,
                      ),
                      onTap: (){
                        setState(() {
                          chosenOne='手机';
                        });
                      },
                    ),
                    Padding(padding: EdgeInsetsDirectional.only(end: 15)),
                    GestureDetector(
                      child: ItemKind(
                        imagePath: 'assets/computer.png',
                        name: '电脑',
                        isChosen: chosenOne,
                      ),
                      onTap: (){
                        setState(() {
                          chosenOne='电脑';
                        });
                      },
                    ),
                    Padding(padding: EdgeInsetsDirectional.only(end: 15)),
                    GestureDetector(
                      child: ItemKind(
                        imagePath: 'assets/more.png',
                        name: '其他',
                        isChosen: chosenOne,
                      ),
                      onTap: (){
                        setState(() {
                          chosenOne='其他';
                        });
                      },
                    )

                  ],
                ),

                Text(
                  '请选择${isLost==true? '失物':'拾物'}位置(可不选)',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20,
                  ),
                ),

                ///选择位置
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: (){
                          RouterManager.router.navigateTo(context, '/map?mode=1');
                        },
                      child: Text('开启地图'),
                    ),
                    ValueListenableBuilder(
                      valueListenable: Config.hasChoosePosition,
                      builder: (context,value,child){
                        return Config.hasChoosePosition.value? Text('已选中位置'):Text('未选中位置');
                       },
                    )
                  ],
                ),

                Text(
                  '请输入详细描述（可空）',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20,
                  ),
                ),

                ///详细内容输入框，输入内容记录在postContentRecorder.value中
                Stack(
                  children: [
                    Container(
                        padding: EdgeInsetsDirectional.only(end:20),
                        child: NewTextField(maxLine: 7, minLine: 7, valueRecorder: postContentRecorder)
                    ),

                    ///从相册选择
                    Positioned(
                      left: 1,
                      bottom: 1,
                      child: IconButton(
                          iconSize: 30,
                          onPressed: ()async{
                            final List<AssetEntity>? result = await AssetPicker.pickAssets(
                                context,
                                pickerConfig: AssetPickerConfig(
                                  maxAssets: 4-photos.length,
                                  requestType: RequestType.image,
                                )
                            );
                            if(result!=null)photos.addAll(result);
                            setState(() {});
                          } ,
                          icon: Icon(Icons.image)
                      ),
                    ),

                    ///打开相机拍摄
                    Positioned(
                        left: 45,
                        bottom: 1,
                        child: IconButton(
                          iconSize: 30,
                          onPressed: ()async {
                            if(photos.length<4){
                              final AssetEntity? entity = await CameraPicker.pickFromCamera(context);
                              if(entity!=null)photos.add(entity);
                              setState(() {});
                            };
                          },
                          icon: Icon(Icons.camera_alt),
                        )
                    )
                  ],
                ),


                Container(
                  height: (MediaQuery.of(context).size.width-20)/4,
                  child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      children: photos.asMap().keys.map((index)=>
                          Stack(
                              children: <Widget>[
                                _photoContainer(
                                    assets: photos[index],
                                    index: index
                                ),
                                IconButton(
                                    onPressed:(){
                                      setState(() {
                                        photos.removeAt(index);
                                      });
                                    },
                                    icon:Icon(Icons.delete,color: Colors.grey,))

                              ]
                          )
                      ).toList(),
                  ),
                ),
                ///提交按钮
                Container(
                  child: ElevatedButton(
                      onPressed: ()async{
                        String b=await DioService.addPost(
                          itemKind: chosenOne,
                          headline: postDescription,
                          content: postContentRecorder.value!=null? postContentRecorder.value:'null',
                          datatime: DateTime.now().toString(),
                          LFtype: isLost==true? '失物':'拾物',
                          latitude: Config.hasChoosePosition.value? Config.nowLatitude.toString():'0',
                          longtitude: Config.hasChoosePosition.value? Config.nowLongitude.toString():'0',
                          WorJ: isBeiyangyuan==true? '北洋园':'卫津路',
                        );
                        for(int i=0;i<photos.length;i++){
                          String a= await DioService.addPhotos(photos[i]);
                          print(a);
                        }
                        RouterManager.router.pop(context);
                      },
                      child: Text('提交')),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}

//选择物品种类组件
class ItemKind extends StatefulWidget {
  final String imagePath;
  final String name;
  final String isChosen;
  ItemKind({Key? key, required this.imagePath, required this.name, required this.isChosen});

  @override
  State<StatefulWidget> createState() => _ItemKindState();
}

class _ItemKindState extends State<ItemKind> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 40,
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            width: 40,
            child: Image(
              image: AssetImage(widget.imagePath),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.isChosen==widget.name? Colors.blue : Colors.white,
                width: 2,
              )
            ),
          ),
          Padding(padding: EdgeInsetsDirectional.only(top: 10)),
          Text(
            widget.name,
            style: TextStyle(color: widget.isChosen==widget.name? Colors.blue : Colors.blueGrey,),
          )
        ],
      ),
    );
  }
}

class _photoContainer extends StatelessWidget {
  final int index;
  final AssetEntity assets;
  _photoContainer({Key? key,required this.assets,required this.index}):super(key:key);
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(2.5),
      child: Stack(
        children: <Widget>[
          Image(
            width: (width-35)/4,
            height: (width-35)/4,
            fit: BoxFit.cover,
            image: AssetEntityImageProvider(assets),
          ),
        ]
      ),
    );
  }
}
