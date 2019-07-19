import 'package:flutter/material.dart';

/// @author chenwei
/// create at 2019-07-18
/// description 带阴影的Container
class ShadowContainer extends StatelessWidget {
  ShadowContainer(
      {Key key,
      @required this.child,
      this.offset = const Offset(1.0, 1.0),
      this.shadowColor = const Color(0x80e7e7e7),
      this.blurRadius = 20.0,
      this.spreadRadius = 0.5,
      this.margin,
      this.borderRadius})
      : super(key: key);
  final Widget child;

  // 阴影的颜色
  final Color shadowColor;

  // 偏移量
  final Offset offset;

  //这个是高斯模糊的半径，半径越大阴影越模糊，半径越小阴影越清晰
  final double blurRadius;

  //这个扩散的半径，半径越大阴影面积越大，值越小阴影面积越小
  final double spreadRadius;

  // margin
  final EdgeInsets margin;

  // 圆角 默认为 10.0
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: borderRadius ??   BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: shadowColor,
                offset: offset,
                blurRadius: blurRadius,
                spreadRadius: spreadRadius),
          ],
        ),
        child: child);
  }
}
