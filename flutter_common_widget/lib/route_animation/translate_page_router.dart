import 'package:flutter/material.dart';

/// @author chenwei
/// create at 2019-07-18
/// description 移动效果的路由动画
/// 1. 右边滑入
/// 2. 底部滑入
class TranslatePageRouter extends PageRouteBuilder {
  // 页面
  final Widget child;

  // 动画的时长
  final Duration duration;

  // 动画样式类型
  final TranslationalType type;

  TranslatePageRouter(
    this.child, {
    this.type = TranslationalType.rightToLeft,
    this.duration = const Duration(milliseconds: 1000),
  }) : super(
            transitionDuration: duration,
            pageBuilder: (BuildContext context, Animation<double> animation1,
                Animation<double> animation2) {
              return child;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              Animation _animation = CurvedAnimation(
                parent: animation1,
                curve: Curves.linearToEaseOut,
                reverseCurve: Curves.linearToEaseOut.flipped,
              );
              Offset begin, end;
              if (type == TranslationalType.bottomToTop) {
                begin = const Offset(0.0, 1.0);
                end = const Offset(0.0, 0.0);
              } else if (type == TranslationalType.leftToRight){
                begin = const Offset(-1.0, 0.0);
                end = const Offset(0.0, 0.0);
              } else if (type  == TranslationalType.rightToLeft){
                begin = const Offset(0.3, 0.0);
                end = const Offset(0.0, 0.0);
              }
              Tween<Offset> _offsetTween = Tween<Offset>(
                begin: begin,
                end: end,
              );
              return FractionalTranslation(
                translation: _offsetTween.evaluate(_animation),
                child: child,
              );
            });
}

enum TranslationalType {
  /// 从右边滑入
  rightToLeft,

  /// 从左边滑入
  leftToRight,

  /// 从左边滑入
  bottomToTop
}
