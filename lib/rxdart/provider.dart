import 'package:flutter/material.dart';

class BlocProvider<T extends BaseBloc> extends StatefulWidget {
  final T bloc;
  final Widget child;

  const BlocProvider({Key key, this.bloc, @required this.child})
      : super(key: key);

  @override
  _BlocProviderState createState() => _BlocProviderState<T>();

  static Type _typeOf<T>() => T;

  static T of<T extends BaseBloc>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider?.bloc;
  }
}

class _BlocProviderState<T> extends State<BlocProvider<BaseBloc>> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.bloc?.dispose();
    super.dispose();
  }
}

abstract class BaseBloc {
  /// 释放bloc 资源
  void dispose();
}
