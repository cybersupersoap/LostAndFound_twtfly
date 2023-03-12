///发帖记录
import 'package:flutter/material.dart';

class PostRecordPage extends StatefulWidget {
  const PostRecordPage({Key? key}) : super(key: key);

  @override
  State<PostRecordPage> createState() => _PostRecordPageState();
}

class _PostRecordPageState extends State<PostRecordPage>
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
    _tabController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('发帖记录'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF01C1EB), Color(0xFF01C1D9)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
          ),
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
                text: "失物",
              ),
              Tab(
                text: "拾物",
              )
            ],
          ),
        ),
      ),
    );
  }
}
