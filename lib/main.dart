import 'package:flutter/material.dart';
import 'package:flutter_app/page/home_page.dart';
import 'package:flutter_app/page/list_view.dart';
import 'package:flutter_app/page/login_page.dart';
import 'package:flutter_app/page/main_page.dart';
import 'package:flutter_app/page/text_field_note.dart';
import 'package:flutter_app/theme.dart';

import 'camera/demo.dart';

void main() => runApp(StartApp());

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "emdd-flutter",
      // 配置app的主题
      theme: getAppThemeData(),
      // 配置路由表
      routes: <String, WidgetBuilder>{
        // 默认初始页面
        "/": (_) => CameraApp(),//MainPage(),
        "/login": (_) => LoginPage(),
        "/text_field_note": (_) => TextFieldNote(),
        "/list_view_note":(_)=> ListViewNote(),
      },
      // 根据路由配置表设置初始显示的页面，如果不设置默认为"/"
      initialRoute: "/",
      // 是否显示Material design布局网格，用于调试
      debugShowMaterialGrid: false,
      // 显示性能标签
      showPerformanceOverlay: false,
      // 是否显示debug标签
      debugShowCheckedModeBanner: false,

    );
  }
}
