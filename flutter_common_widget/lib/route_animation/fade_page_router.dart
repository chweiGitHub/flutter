import 'package:flutter/material.dart';

/// @author chenwei
/// create at 2019-07-18
/// description 渐变效果的路由动画
class FadePageRouter extends PageRouteBuilder {
  // 页面
  final Widget widget;

  // 渐变的位置
  final Alignment alignment;

  // 动画时长
  final Duration duration;

  // 开始帧
  final double begin;

  // 结束帧
  final double end;

  FadePageRouter(this.widget,
      {this.alignment = Alignment.center,
      this.begin = 0.0,
      this.end = 1.0,
      this.duration = const Duration(milliseconds: 100)})
      : super(
            transitionDuration: duration,
            pageBuilder: (BuildContext context, Animation<double> animation1,
                Animation<double> animation2) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              return FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: animation1, curve: Curves.fastOutSlowIn),
                ),
                child: child,
              );
            });
}
