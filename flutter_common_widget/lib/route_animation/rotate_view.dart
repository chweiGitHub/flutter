import 'package:flutter/material.dart';

/// @author chenwei
/// create at 2019-06-27
/// description 无限转圈的loading view .
class RotateView extends StatefulWidget {
  static const Widget defaultWidget = Icon(
    Icons.ac_unit,
    color: Colors.lightBlue,
  );

  const RotateView({Key key, this.view: defaultWidget}) : super(key: key);
  final Widget view;

  @override
  State<StatefulWidget> createState() {
    return _RotateViewState();
  }
}

class _RotateViewState extends State<RotateView> with TickerProviderStateMixin {
  AnimationController _controller; //动画控制器

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 1));
    _controller.addStatusListener((AnimationStatus status) {

      if (status == AnimationStatus.completed) {

        _controller.repeat();
      }
    });

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {

    return new RotationTransition(
      //旋转动画
      turns: new Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Center(
        child:  widget.view,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
