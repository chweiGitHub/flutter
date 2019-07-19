import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  /// 外边距
  final EdgeInsets margin;

  /// 内边距 -- 文字与上下左右的边距
  final EdgeInsets padding;

  /// 可以设置圆角，背景颜色等参数
  final BoxDecoration decoration;

  /// 显示的内容
  final dynamic child;

  /// 点击事件
  final Function onPress;

  const CustomButton(this.child, {
    Key key,
    this.margin = const EdgeInsets.all(10.0),
    this.padding = const EdgeInsets.only(
      left: 30.0,
      right: 30.0,
      top: 10.0,
      bottom: 10.0,
    ),
    this.decoration,
    this.onPress,
  })
      : assert(child != null, "CustomButtom child not null."),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget childView;
    if (child is Widget)
      childView = child;
    else if (child is String)
      childView = Text(child);
    else
      childView = Text("button");
    decoration ?? BoxDecoration();

    return Container(
      margin: margin,
      child: GestureDetector(
        onTap: () {
          if (onPress != null) {
            onPress();
          }
        },
        child: Container(
          padding: padding,
          decoration: decoration,
          child: childView,
        ),
      ),
    );
  }
}

class CustomCircleLeftRightButton extends StatelessWidget {
  ///  背景色
  final Color bgColor;
  final dynamic child;
  final Function onPress;

  const CustomCircleLeftRightButton(
      {Key key, this.bgColor = const Color(0xfffafafa), this.child, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget childView;
    if (child != null) {
      if (child is Widget)
        childView = child;
      else if (child is String)
        childView = Text(child);
      else
        childView = Text("button");
    } else {
      childView = Text("button");
    }

    return CustomButton(
      childView,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: bgColor,
      ),
      onPress: onPress,
    );
  }
}
