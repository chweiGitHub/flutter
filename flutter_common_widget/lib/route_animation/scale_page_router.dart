import 'package:flutter/material.dart';

/// @author chenwei
/// create at 2019-07-18
/// description 缩放效果的路由动画
class ScalePageRouter extends PageRouteBuilder {
  // 页面
  final Widget child;

  // 缩放的位置
  final Alignment alignment;

  // 动画的时长
  final Duration duration;

  // 开始帧--默认0
  final double begin;

  // 结束帧--默认1.0
  final double end;

  ScalePageRouter(this.child,
      {this.alignment = Alignment.topRight,
      this.duration = const Duration(milliseconds: 500),
      this.begin = 0,
      this.end = 1.0})
      : super(
            transitionDuration: duration,
            pageBuilder: (BuildContext context, Animation<double> animation1,
                Animation<double> animation2) {
              return child;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              return ScaleTransition(
                  alignment: alignment,
                  scale: Tween(begin: begin, end: end).animate(
                      CurvedAnimation(parent: animation1, curve: Curves.ease)),
                  child: child);
            });
}
