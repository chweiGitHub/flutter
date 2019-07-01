import 'package:flutter/material.dart';

void main() {
  return runApp(Demo());
}

class Demo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DemoState();
  }
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("focus_node_demo"),
        ),
        body: FocusTestRoute(),
      ),
    );
  }
}

class FocusTestRoute extends StatefulWidget {
  @override
  _FocusTestRouteState createState() => new _FocusTestRouteState();
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  FocusNode focusNodeUserName = new FocusNode();
  FocusNode focusNodePassword = new FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            focusNode: focusNodeUserName,
            //关联focusNodeUserName
            decoration: InputDecoration(labelText: "用户名"),
            textInputAction: TextInputAction.next,
            // 设置键盘 "下一步" 按钮
            onSubmitted: (_) {
              // 点击键盘上的 "下一步" 回调
              focusNodeUserName.unfocus();
              FocusScope.of(context).requestFocus(focusNodePassword);
            },
          ),
          TextField(
            focusNode: focusNodePassword, //关联focusNodePassword
            decoration: InputDecoration(labelText: "密码"),
            textInputAction: TextInputAction.done, // 设置键盘 "完成" 按钮
            onSubmitted: (_) {
              // 点击键盘上的 "完成" 回调
              // 关闭弹出的键盘
              focusNodePassword.unfocus();
              // 如果没有关联focusnode 要关闭键盘可以用：  FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ],
      ),
    );
  }
}
