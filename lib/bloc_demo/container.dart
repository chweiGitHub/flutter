import 'package:flutter/material.dart';

import 'count_bloc.dart';


// 组装widget

class ContainerView extends InheritedWidget {
  ContainerView({Widget child}) : super(child: child);

    CountModel data = CountModel();

  @override
  bool updateShouldNotify(ContainerView oldWidget) {
    return oldWidget.data != data;
  }

  static CountModel of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ContainerView) as ContainerView).data;
  }
}
