import 'package:flutter/material.dart';

/*
* app主题
* */
getAppThemeData() => ThemeData(
      // 前景色， 如进度条的前景色
      accentColor: Colors.yellow,
      // 背景色， 如进度条的背景色
      backgroundColor: Colors.green,
      // app主要部分的背景色--appbar, tabbar等
//      primaryColor: Colors.red,
      // 按钮的默认填充色
      buttonColor: Colors.lightBlue[300],
      // widget无效时显示的颜色
      disabledColor: Colors.purple[300],
      // 提示文本hint的颜色, 如TextField
      hintColor: Colors.grey[400],
      // tab指示器的颜色
      indicatorColor: Colors.lightGreen,
      // 页面的背景色
      scaffoldBackgroundColor: Colors.white,
      // 切换主题色--亮色or暗色
//      brightness: Brightness.light,
      primarySwatch: Colors.yellow,//MaterialŒColor(1, {1:Colors.limeAccent, 2: Colors.deepOrange}),
      // 文本的主题
      textTheme: TextTheme(
        body1: TextStyle(color: Colors.deepOrangeAccent),
        body2: TextStyle(color: Colors.deepOrangeAccent),
        display1: TextStyle(color: Colors.deepOrangeAccent),
        display2: TextStyle(color: Colors.deepOrangeAccent),
        // Used for the primary text in lists (e.g., [ListTile.title])； TextField默认字体的颜色
        subhead: TextStyle(color: Colors.deepOrangeAccent),
//        primarySwatch: Colors.indigoAccent,
      ),
//      primaryTextTheme: TextTheme(
//            body1: TextStyle(color: Colors.deepOrangeAccent),
//            body2: TextStyle(color: Colors.deepOrangeAccent),
//            display1: TextStyle(color: Colors.deepOrangeAccent),
//            display2: TextStyle(color: Colors.deepOrangeAccent),
//      ),
//      accentTextTheme: TextTheme(
//            body1: TextStyle(color: Colors.deepOrangeAccent),
//            body2: TextStyle(color: Colors.deepOrangeAccent),
//            display1: TextStyle(color: Colors.deepOrangeAccent),
//            display2: TextStyle(color: Colors.deepOrangeAccent),
//      ),
//      primaryColorDark: Colors.pink,
//      fontFamily: "MaoTi",
//      highlightColor: Colors.purple,

//      typography: Typography(
//        white: TextTheme(
//          body1: TextStyle(color: Colors.deepOrangeAccent),
//          body2: TextStyle(color: Colors.deepOrangeAccent),
//          display1: TextStyle(color: Colors.deepOrangeAccent),
//          display2: TextStyle(color: Colors.deepOrangeAccent),
//        ),
//      ),
    );
