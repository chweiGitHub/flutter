import 'package:flutter/material.dart';
import 'package:flutter_app/inherited_demo/user_info.dart';




/// @author chenwei
/// create at 2019-06-18
/// description 定义一个父widget
class InheritedParent extends InheritedWidget {
  InheritedParent({@required this.data, this.change,  Widget child}) : super(child: child);

  final UserInfo data;

  final Function() change;

  static InheritedParent of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(InheritedParent);
  }

  @override
  bool updateShouldNotify(InheritedParent oldWidget) {
    return oldWidget.data != data;
  }
}
