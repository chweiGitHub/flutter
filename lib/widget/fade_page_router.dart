import 'package:flutter/material.dart';

// 渐变效果的路由动画
class FadePageRouter extends PageRouteBuilder {
  final Widget widget;
  Alignment alignment;
  num duration;

  FadePageRouter(this.widget, {this.alignment = Alignment.center, this.duration  = 100})
      : super(
            transitionDuration:  Duration(milliseconds: duration),
            pageBuilder: (BuildContext context, Animation<double> animation1,
                Animation<double> animation2) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {

              Animation animation  =  Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animation1, curve: Curves.fastOutSlowIn));

              return FadeTransition(
//                  alignment: Alignment.topRight,
//                  scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//                      parent: animation1, curve: Curves.fastOutSlowIn)),

              opacity: animation,
                child: child,
              );
            });
}
