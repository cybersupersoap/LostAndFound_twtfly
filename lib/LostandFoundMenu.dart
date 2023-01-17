import 'package:flutter/material.dart';
import 'NewWidgets/DropDownMenu.dart';
import 'RouterManager.dart';

import 'TestFile.dart';

class LostandFoundMenu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_LostandFoundMenuState ();
}

class _LostandFoundMenuState extends State<LostandFoundMenu> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  static const List<Widget> homeTopTabList =[
    Text(
      '拾物',
      style: TextStyle(
        color: Colors.blueGrey,
        fontSize: 20,
      ),
    ),
    Text(
      '失物',
      style: TextStyle(
        color: Colors.blueGrey,
        fontSize: 20,
      ),
    )
  ];//上部标签栏

  @override
  void initState() {
    super.initState();
    _tabController=TabController(length: homeTopTabList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: DropDownMenu(choices:const ['全部','雨伞','水杯','钥匙'],width:100,func: 'changeItemKind'),//下拉选单
          leadingWidth: 100,
          title: TextField(
          ),

          bottom: TabBar(
            tabs:homeTopTabList,
            controller: _tabController,
          ),

          actions:<Widget>[
            Padding(
              padding: const EdgeInsets.only(right:10),
              child: Icon(
                  Icons.search,
                  color: Colors.blue,
              ),
            ),
          ]
        ),

        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Stack(
                  children: <Widget>[
                    Container(
                        child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            Container(
                              child: TestFile.postlist.length==0? Center(child: Text('暂无'),):
                              ListView.separated(
                                key: UniqueKey(),
                                itemBuilder: (BuildContext context, int index) {
                                  return TestFile.postlist[index];
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return Divider(height: 1,color: Colors.grey,);
                                },
                                itemCount: TestFile.postlist.length,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text('尚在天国的失物列表'),
                            )
                          ],
                        )
                    ),

                    //这是发帖按钮
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: ElevatedButton(
                        onPressed: (){RouterManager.router.navigateTo(context, '/create_new_post');},
                        child:Text(
                          '发帖',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(CircleBorder()),
                          minimumSize: MaterialStateProperty.all(Size(80, 80)),//设置按钮大小
                        ),
                      ),
                    ),

                    ///这是刷新按钮
                    Positioned(
                      bottom: 110,
                      right: 20,
                      child: ElevatedButton(
                        onPressed: (){setState(() {});},
                        child:Text(
                          '刷新',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(CircleBorder()),
                          minimumSize: MaterialStateProperty.all(Size(80, 80)),//设置按钮大小
                        ),
                      ),
                    )
                  ]
              ),
            ),
          ],
        )
    );
  }

}