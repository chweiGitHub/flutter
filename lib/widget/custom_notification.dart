import 'package:flutter/material.dart';


/*
 * 子widget与父widget通过Notification通信   -- 动画
 */
class CustomNotification extends Notification {
  CustomNotification(this.startOffset, this.size);
  // 被点击控制的位置信息
  final Offset startOffset;

  final Size size;
}
