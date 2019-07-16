import 'package:flutter/material.dart';

class AnimationMoveView extends StatefulWidget {
  final Widget animationView;
  final Offset startOffset, endOffset;
  final Size startSize, endSize;
  final Widget child;

  const AnimationMoveView(
      {Key key,
      this.animationView,
      this.startOffset,
      this.endOffset,
      this.startSize,
      this.endSize,
      this.child})
      : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AnimationMoveView> {
  List<AnimationMoveViewItem> childrens = [];

  @override
  void initState() {
    super.initState();
    print("AnimationMoveView---initState....");
  }


  @override
  void didUpdateWidget(AnimationMoveView oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("AnimationMoveView---didUpdateWidget.... ${widget.startOffset?.toString()}");
    if (widget.child != null) {
      childrens.add(AnimationMoveViewItem(
        startOffset: widget.startOffset,
        endOffset: widget.endOffset,
        startSize: widget.startSize,
        endSize: widget.endSize,
        child: widget.child,
        onComplete: () {
          if (childrens != null && childrens.length > 0) {
            setState(() {
              childrens.removeAt(0);
            });
          }
        },
      ));
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("AnimationMoveView---didChangeDependencies.... ${widget.startOffset?.toString()}");
//    if (widget.child != null) {
//      childrens.add(AnimationMoveViewItem(
//        startOffset: widget.startOffset,
//        endOffset: widget.endOffset,
//        startSize: widget.startSize,
//        endSize: widget.endSize,
//        child: widget.child,
//        onComplete: () {
//          if (childrens != null && childrens.length > 0) {
//            setState(() {
//              childrens.removeAt(0);
//            });
//          }
//        },
//      ));
//      setState(() {});
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: childrens,
    );
  }
}

class AnimationMoveViewItem extends StatefulWidget {
  final Offset startOffset, endOffset;
  final Size startSize, endSize;
  final Widget child;
  final Function onComplete;

  const AnimationMoveViewItem(
      {Key key,
      this.startOffset,
      this.endOffset,
      this.startSize,
      this.endSize,
      this.child,
      this.onComplete})
      : super(key: key);

  @override
  _AnimationMoveViewItemState createState() => _AnimationMoveViewItemState();
}

class _AnimationMoveViewItemState extends State<AnimationMoveViewItem>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              widget.onComplete();
            }
          })
          ..addListener(() {
            setState(() {});
          });
    _animation = Tween(begin: 0, end: 1.0).animate(_controller);

    Future(() {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    Offset sOffset = widget.startOffset ?? Offset(0, 0);
    Offset eOffset = widget.endOffset ?? Offset(0, 0);

    double dx = eOffset.dx - sOffset.dx;
    double dy = eOffset.dy - sOffset.dy;

    double left = sOffset.dx + dx * _animation.value;
    double top = sOffset.dy + dy * _animation.value;

    return Positioned(
      top: top,
      left: left,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
