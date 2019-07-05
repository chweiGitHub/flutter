

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("首页"),),
      body: Column(
        children: <Widget>[

          Text("home"),
          RaisedButton(
            child: Text("测试按钮"),
//            onPressed: (){
//              print("...");
//            },
          ),
          LinearProgressIndicator(value: 0.6,),
          TextField(
            decoration: InputDecoration(
              hintText: "请输入姓名"
            ),
          ),
        ],
      ),
    );
  }
}