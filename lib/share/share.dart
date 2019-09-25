//import 'package:flutter/material.dart';
//
//import 'package:flutter_umengshare/flutter_umengshare.dart';
//
//void main() => runApp(MainApp());
//
//class MainApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: ShareDemo(),
//    );
//  }
//}
//
//class ShareDemo extends StatefulWidget {
//  @override
//  _ShareDemoState createState() => _ShareDemoState();
//}
//
//class _ShareDemoState extends State<ShareDemo> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("share"),
//      ),
//      body: Column(
//        children: <Widget>[
//          RaisedButton(
//            child: Text("share"),
//            onPressed: () {
//              share();
//            },
//          )
//        ],
//      ),
//    );
//  }
//
//  void share() {
//    FlutterUmengshare.initUmengAppKey("5d23f8b80cafb25fef000ae6");
////    FlutterUmengshare.setupUSharePlatforms(UMPlatform.Wechat);
//    FlutterUmengshare.shareText(UMSharePlatform.WechatSession, "share test")
//        .then(((res) {
//      print("=========================分享返回的内容为： ${res}");
//    }));
//  }
//}
