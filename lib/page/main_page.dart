import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/page/base_technology_page.dart';
import 'package:flutter_app/page/me_page.dart';
import 'package:flutter_app/page/widget_page.dart';
import 'package:flutter_app/page/animation_demo1.dart';
import 'package:flutter_app/widget/custom_notification.dart';
import 'package:flutter_app/widget/dot_to_me_animation.dart';
import 'package:flutter_app/widget/dot_to_me_animation_container.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> with TickerProviderStateMixin {
  // 动画相关 -- start
  AnimationController controller;
  Animation<double> animation;
  CurvedAnimation curve;
  bool isForward = false;
  bool _animationComplete = false; // 动画层是否显示
  GlobalKey _meKey = GlobalKey();
  Offset _startOffset;
  Offset _endOffset;
  Size _clickWidgetSize; // 被点击的widget的size
  Size _endWidgetSize; // 目标Widget的Size
  List<Widget> dotViews = [];

  // 动画相关  -- end

  int _currentIndex = 0;
  List<BottomNavigationBarItem> _bottomItems = [];
  List<Widget> _pageWidgets = [
    WidgetPage(),
    BaseTechnologyPage(),
    AnimationPage03()
  ];

  var _tabsData = [
    {"icon": Icons.home, "value": "Widget"},
    {"icon": Icons.text_rotation_angleup, "value": "基础知识"},
    {"icon": Icons.account_circle, "value": "我"},
  ];

  void _onBottomBarTap(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    initAnimation();

    initData();
//
//    Timer(Duration(seconds: 6), () {
//      // 开启动画
//      isForward ? controller.reverse() : controller.forward();
//      isForward = !isForward;
//    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 页面渲染完成后获取到导航栏"我"widget的位置信息
      RenderBox box = _meKey.currentContext.findRenderObject();
      _endOffset = box.localToGlobal(Offset.zero);
      _endWidgetSize = box.size;
    });
  }

  void initAnimation() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    animation.addListener(() {
      setState(() {});
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print("动画已完成 ");
        setState(() {
          _animationComplete = true;
        });
      }
    });
  }

  void initData() {
    _bottomItems.clear();
    for (int i = 0; i < _tabsData.length; i++) {
      var data = _tabsData[i];
      BottomNavigationBarItem item;
      if (i == 2) {
        item = BottomNavigationBarItem(
          icon: Icon(data['icon'], key: _meKey),
          title: Text(data['value']),
        );
      } else {
        item = BottomNavigationBarItem(
          icon: Icon(data['icon']),
          title: Text(data['value']),
        );
      }
      _bottomItems.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (CustomNotification notification) {
        print(
            "子widget传递过来的信息： ${notification.startOffset.dx}----- ${notification.startOffset.dy}");
        // 收到子Widget的通知，开启动画
        setState(() {
          _startOffset = notification.startOffset;
          _clickWidgetSize = notification.size;
          dotViews = [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.red,
              ),
              width: 20.0,
              height: 20.0,
            )
          ];
        });
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Scaffold(
              body: IndexedStack(
                index: _currentIndex,
                children: _pageWidgets,
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: _bottomItems,
                onTap: _onBottomBarTap,
                currentIndex: _currentIndex,
              ),
            ),

            DotToMeAnimationContainer(
              startOffset: _startOffset,
              endOffset: _endOffset,
              startSize: _clickWidgetSize,
              endSize: _endWidgetSize,
              children: dotViews,
            ),

//            Offstage(
//              offstage: _animationComplete,
//              child: Container(
//                alignment: Alignment.center,
//                color: Colors.transparent,
//                child: Transform.translate(
//                    offset: Offset(0.0, 1000.0 * animation.value),
//                    child: InkWell(
//                      onTap: () {
//                        print("测试translate.....");
//                      },
//                      child: FlutterLogo(size: 100.0),
//                    )),
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}
