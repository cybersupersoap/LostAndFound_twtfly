import 'package:flutter/material.dart';

class MyInformationPage extends StatelessWidget {
  const MyInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        //minimum: EdgeInsets.all(30),
        child: Column(
      children: [
        Container(
            margin: EdgeInsets.all(30),
            height: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://inews.gtimg.com/newsapp_bt/0/14297516724/641'),
                  fit: BoxFit.cover,
                ),

                ///这里的颜色均不知道怎么写，之后再改
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue),
            child: Row(children: [
              ///头像部分,上传图像的功能还没有
              InkWell(
                child: Container(
                  margin: EdgeInsets.all(20),
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://upload.pig66.com/uploadfile/2017/0511/20170511075802322.jpg'),
                          fit: BoxFit.cover)),
                ),
              ),

              ///昵称部分
              Container(
                child: Text('未知的名字hahahaha'),
                //width: 150,
                //height: 50,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'change_name');
                  },
                  icon: Icon(Icons.edit)),
            ])),
        Row(
          children: [
            ///我的消息
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'my_message');
              },
              child: Container(
                width: 130,
                height: 170,
                margin: EdgeInsets.fromLTRB(30, 30, 15, 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://inews.gtimg.com/newsapp_bt/0/14297516724/641'),
                      fit: BoxFit.cover,
                    )),
                child: Text(
                  '我的消息',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),

            ///发帖记录
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'post_record');
              },
              child: Container(
                width: 130,
                height: 170,
                margin: EdgeInsets.fromLTRB(15, 30, 30, 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://inews.gtimg.com/newsapp_bt/0/14297516724/641'),
                      fit: BoxFit.cover,
                    )),
                child: Text(
                  '发帖记录',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.all(30),
          height: 150,
          width: 350,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://inews.gtimg.com/newsapp_bt/0/14297516724/641'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue),
          child: Text(
            '我的成就',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        )
      ],
    ));
  }
}
