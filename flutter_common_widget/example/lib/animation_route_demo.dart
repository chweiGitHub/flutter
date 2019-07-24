  
import 'package:example/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common_widget/route_animation/scale_page_router.dart';
import 'package:flutter_common_widget/route_animation/translate_page_router.dart';
import 'package:flutter_common_widget/route_animation/fade_page_router.dart';

import 'demo_page.dart';

class AnimationRouteDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> listViews = <Widget>[
      ListTile(
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.green,
        ),
        title: Text("从右上角缩放"),
        onTap: () {
          Navigator.of(context).push(ScalePageRouter(
            DemoPage(showInfo: "从右上角缩放"),
          ));
        },
      ),
      ListTile(
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.green,
        ),
        title: Text("中间缩放"),
        onTap: () {
          Navigator.of(context).push(ScalePageRouter(
            DemoPage(showInfo: "中间缩放"),
            alignment: Alignment.center,
          ));
        },
      ),
      ListTile(
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.green,
        ),
        title: Text("左边中间缩放"),
        onTap: () {
          Navigator.of(context).push(ScalePageRouter(
            DemoPage(showInfo: "左边中间缩放"),
            alignment: Alignment.centerLeft,
          ));
        },
      ),
      ListTile(
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.green,
        ),
        title: Text("左上角缩放"),
        onTap: () {
          Navigator.of(context).push(ScalePageRouter(
            DemoPage(showInfo: "左上角缩放"),
            alignment: Alignment.topLeft,
            begin: 0.6,
            duration: Duration(seconds: 1),
          ));
        },
      ),
      ListTile(
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.green,
        ),
        title: Text("从右往左 "),
        onTap: () {
//          Navigator.of(context)
//              .push(TranslatePageRouter(DemoPage(showInfo: "从右往左")));
        Navigator.of(context).push(CupertinoPageRouteV2(title:"bbb",builder: (c)=> DemoPage(), fullscreenDialog: false));
        }
      ),
      ListTile(
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.green,
        ),
        title: Text("从右往左 official"),
        onTap: () {
//          Navigator.of(context)
//              .push(TranslatePageRouter(DemoPage(showInfo: "从右往左")));
          Navigator.of(context).push(CupertinoPageRoute(title:"aaa",builder: (c)=> DemoPage(), fullscreenDialog: false));
        },
      ),
      ListTile(
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.green,
        ),
        title: Text("从下往上 "),
        onTap: () {
          Navigator.of(context).push(
            TranslatePageRouter(DemoPage(showInfo: "从下往上"),
                type: TranslationalType.bottomToTop),
          );
        },
      ),
      ListTile(
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.green,
        ),
        title: Text("渐变效果 "),
        onTap: () {
          Navigator.of(context).push(
            FadePageRouter(
              DemoPage(showInfo: "渐变效果"),
              duration: Duration(seconds: 1),
            ),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("路由动画"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: ListTile.divideTiles(
            tiles: listViews,
            color: Colors.green,
          ).toList(),
        ),
      ),
    );
  }
}
