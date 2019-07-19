import 'package:flutter/material.dart';

// 动画蒙层
class AnimationMoveContainer extends StatefulWidget {
  final Widget child;
  final Offset startOffset, endOffset;
  final Size startSize, endSize;

  const AnimationMoveContainer(
      {Key key,
      this.startOffset,
      this.endOffset,
      this.startSize,
      this.endSize,
      this.child})
      : super(key: key);

  @override
  _AnimationMoveContainerState createState() => _AnimationMoveContainerState();
}

class _AnimationMoveContainerState extends State<AnimationMoveContainer> {
  List<AnimationMoveView> list = [];

  @override
  void didUpdateWidget(AnimationMoveContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.child != null) {
      list.add(
        AnimationMoveView(
          startSize: widget.startSize,
          startOffset: widget.startOffset,
          endSize: widget.endSize,
          endOffset: widget.endOffset,
          child: widget.child,
          onComplete: () {
            // 当动画完成的时候移除view
            list?.removeAt(0);
            setState(() {});
          },
        ),
      );
      setState(() {
//        list = temList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: list,
    );
  }
}

// 具体操作移动变换的view
class AnimationMoveView extends StatefulWidget {
  final Widget child;
  final Offset startOffset, endOffset;
  final Size startSize, endSize;
  final Function onComplete;

  const AnimationMoveView(
      {Key key,
      this.startOffset,
      this.endOffset,
      this.startSize,
      this.endSize,
      this.child,
      this.onComplete})
      : super(key: key);

  @override
  _AnimationMoveViewState createState() => _AnimationMoveViewState();
}

class _AnimationMoveViewState extends State<AnimationMoveView>
    with SingleTickerProviderStateMixin {
  // 这里应该是需要3个动画的， 一个小圆点在开始位置由小变大，一个移动动画， 一个小圆点在结束位置由大变小
  // 1. 移动动画
  AnimationController _controller;
  Animation _animation;
  // todo 2. 由小变大动画
  // todo 3. 由大变小动画

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete();
        }
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
//   Future((){
//     _controller.forward();
//   });
  }

  @override
  Widget build(BuildContext context) {
    double left;
    double top;

    Offset sOffset = widget.startOffset ?? Offset(0, 0);
    Offset eOffset = widget.endOffset ?? Offset(0, 0);

    double dx = eOffset.dx - sOffset.dx;
    double dy = eOffset.dy - sOffset.dy;

    //  todo 这里只做了大概的位置，要精准定位到开始View和结束View的话，需要配合Size。
    left = sOffset.dx + dx * _animation.value;
    top = sOffset.dy + dy * _animation.value;

    return Positioned(
      left: left,
      top: top,
      child: widget.child,
    );
  }
  @override
  void dispose() {
    // 页面销毁一定要记得释放动画资源
    _controller.dispose();
    super.dispose();
  }
}
