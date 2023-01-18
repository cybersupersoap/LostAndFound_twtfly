///我的消息界面
import 'package:flutter/material.dart';

class MyMessagePage extends StatefulWidget {
  const MyMessagePage({Key? key}) : super(key: key);

  @override
  State<MyMessagePage> createState() => _MyMessagePageState();
}

class _MyMessagePageState extends State<MyMessagePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      ///toast消息提示框等会再写
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('我的消息'),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios)),
            bottom: TabBar(
              controller: _tabController,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              indicatorWeight: 2,
              indicatorColor: Colors.orangeAccent,
              tabs: [
                Tab(
                  text: "全部",
                ),
                Tab(
                  text: "回复",
                ),
                Tab(
                  text: "系统消息",
                )
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              ListView(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                children: [
                  ///一个样例
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orangeAccent),
                    height: 100,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              '回复:IPH',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                              ),
                            ),
                            height: 40,
                          ),
                          Container(
                            child: Text('楼主能再补充一些信息吗,这个手机也许是我的'),
                            height: 40,
                          ),
                          Row(
                            children: [
                              Text('Big Fish'),
                              SizedBox(
                                width: 250,
                              ),
                              Text('两分钟前')
                            ],
                          )
                        ]),
                  )
                ],
              ),

              ///之后再补充
              ListView(),
              ListView(),
            ],
          ),
        ));
  }
}
