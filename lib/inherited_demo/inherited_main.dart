import 'package:flutter/material.dart';
import 'package:flutter_app/inherited_demo/son.dart';
import 'package:flutter_app/inherited_demo/user_info.dart';

import 'inherited_parent.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  UserInfo data;

  @override
  void initState() {
    data = UserInfo(1001, "spark");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "InheritedWidget demo",
        home: Scaffold(
          appBar: AppBar(title: Text("inherited widget demo"),),
          body: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  setState(() {
                    data = UserInfo((data.id + 1), "${data.id}-spark");
                  });
                },
                child: Text("change data "),
              ),
              InheritedParent(
                data: data,
                change: () {
                  print("你点击了Change。。。。。");
                  setState(() {
                    data = UserInfo(data.id, "我是change后的name");
                  });
                },
                child: Son(),
              ),
            ],
          ),
        ));
  }
}
