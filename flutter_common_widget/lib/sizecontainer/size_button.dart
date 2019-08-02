import 'package:flutter/material.dart';

/// @author chenwei
/// create at 2019-07-17
/// description 获取控件位置和大小

class SizeButton extends StatelessWidget {
  final Function onPress;
  final Widget child;

  const SizeButton({Key key, this.onPress, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () {
        RenderBox renderBox = context.findRenderObject();
        Offset startOffset = renderBox.localToGlobal(Offset.zero);
        Size startSize = renderBox.size;
        if (onPress != null) onPress(startOffset, startSize);
      },
    );
  }
}
