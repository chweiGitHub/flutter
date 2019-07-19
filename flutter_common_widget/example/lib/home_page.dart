import 'package:flutter/material.dart';
import 'package:flutter_common_widget/utils/index.dart';

import 'animation_route_demo.dart';
import 'button_demo.dart';
import 'dlg_demo.dart';
import 'shadow_demo.dart';
import 'text_field_note.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SizeUtil.init(context);
    });
  }

  List menuList = [
    {"name": "弹框", "route": DlgList()},
    {"name": "输入框", "route": TextFieldNote()},
    {"name": "路由动画", "route": AnimationRouteDemo()},
    {"name": "阴影", "route": ShadowDemo()},
    {"name": "按钮", "route": ButtonDemo()},
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> views = [];
    for (var value in menuList) {
      views.add(ListTile(
        title: Text(value["name"]),
        trailing: Icon(Icons.navigate_next, color: Colors.green,),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => value["route"]));
        },
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter 常用控件/效果Demo"),
      ),
      body: ListView(
        children: ListTile.divideTiles(tiles: views, color: Colors.green).toList(),
      ),
    );
  }
}
