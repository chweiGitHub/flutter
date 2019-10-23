import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'index.dart';

void main() => runApp(StartPage());

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('size demo '),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Container(
            child:
            FlutterAutoText(
              width: 50, //这个是必须的
              text: "我是返回覅爱上覅回复爱好佛和or哈佛和快递费哈拉海发发火螺蛳粉 地方哈利法护理费",
              textSize: 12,
            ),
          )),
    );
  }
}
