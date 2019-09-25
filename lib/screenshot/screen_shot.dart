import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

main() => runApp(StartPage());

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<TestPage> {
  GlobalKey _screenShotKey = GlobalKey();
  List<Uint8List> imageDataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("截图保存到本地demo"),
        actions: <Widget>[
          GestureDetector(
            child: Text(
              "截图保存到本地",
            ),
            onTap: () {
              _save();
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          RepaintBoundary(
            key: _screenShotKey,
            child: Container(
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/food03.jpeg"),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Text(
                      '''弯弯月出挂城头，城头月出照凉州。
凉州七里十万家，胡人半解弹琵琶。
琵琶一曲肠堪断，风萧萧兮夜漫漫。
河西幕中多故人，故人别来三五春。
花门楼前见秋草，岂能贫贱相看老。
一生大笑能几回，斗酒相逢须醉倒。''',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container (height: 20.0,color: Colors.lime,),
          Column(
            children: imageDataList.map((Uint8List data) {
              return Image.memory(data);
            }).toList(),
          ),

          //  imageData != null ? Image.memory(imageData) : Container(),
        ],
      ),
    );
  }

  /// 截图保存到本地
  _save() async {
    print("截图保存到本地");
    // 1. 通过globalkey 的 context 获取RenderRepaintBoundary;
    RenderRepaintBoundary renderRepainBoundary =
        _screenShotKey.currentContext.findRenderObject();
    // 2. 通过RenderRepaintBoundary 的toImage（） 方法获取到Image对象。
    ui.Image image = await renderRepainBoundary.toImage();
    // 3. 将ui.Image对象转成ByteData
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    // 4. 通过ByteData buffer的asUint*List*()方法将ByteData转成Uint8List
    // Uint8List 也是一种数据在内存中存在的格式，为什么要转成这种格式呢？
    // 主要是为了我们后面通过Image.memory()方法来加载内存中的图片并显示到屏幕上做准备的。
    // 跟一下源码我们就知道，Image.memory的核心参数是一个类型为Uint8List的bytes
    Uint8List util8list = byteData.buffer.asUint8List();
    // 直接显示到屏幕上
    setState(() {
      imageDataList.add(util8list);
    });
    // 5. 写入到本地的文件中
    // 下入之前要先考虑客户端的权限问题， Android和IOS两端的权限请求应该是不一样。 还有存储目录path的不同都是要考虑的
    String path ;
    // todo 存到到本地之前需要解决的2点问题---》 1. request permission  2. get the path to store image file .
    File(path).writeAsBytes(util8list);
  }
}
