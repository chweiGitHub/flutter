import 'package:flutter/material.dart';

/// @author chenwei
/// create at 2019-07-18
/// description 自定义Notification
/// type 广播标识
/// data 携带的数据
///
/// 可在广播的接收位置，更加Type来获取对应携带的数据
class CustomNotification<T> extends Notification {
  CustomNotification(this.type, this.data);

  final int type;

  final T data;
}
