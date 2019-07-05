import 'package:flutter/material.dart';

//缩放效果的路由动画
class ScalePageRouter extends PageRouteBuilder {
  final Widget widget;
  Alignment alignment;

  ScalePageRouter(this.widget, {this.alignment = Alignment.center})
      : super(
            transitionDuration: const Duration(seconds: 1),
            pageBuilder: (BuildContext context, Animation<double> animation1,
                Animation<double> animation2) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              return ScaleTransition(
                  alignment: Alignment.topRight,
                  scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animation1, curve: Curves.fastOutSlowIn)),
                  child: child);
            });
}
