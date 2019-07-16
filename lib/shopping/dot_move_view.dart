import 'package:flutter/material.dart';

class DotMoveView extends StatefulWidget {
  final Widget child;
  final Offset startOffset, endOffset;
  final Size startSize, endSize;

  const DotMoveView(
      {Key key,
      this.child,
      this.startOffset,
      this.endOffset,
      this.startSize,
      this.endSize})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DotMoveViewState();
  }
}

class _DotMoveViewState extends State<DotMoveView>
    with SingleTickerProviderStateMixin {
  List<Widget> cViews = [];

  @override
  void didUpdateWidget(DotMoveView oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("DotMoveView---- didUpdateWidget");
    if (widget.child != null) {
      cViews.add(DotMoveItemView(
        startSize: widget.startSize,
        startOffset: widget.startOffset,
        endSize: widget.endSize,
        endOffset: widget.endOffset,
        onComplete: () {
          if (cViews != null && cViews.length > 0) {
            cViews.removeAt(0);
          }
        },
        child: widget.child,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: cViews);
  }
}

class DotMoveItemView extends StatefulWidget {
  final Widget child;
  final Offset startOffset, endOffset;
  final Size startSize, endSize;
  final Function onComplete;

  const DotMoveItemView(
      {Key key,
      this.startOffset,
      this.endOffset,
      this.startSize,
      this.endSize,
      this.child,
      this.onComplete})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DotMoveItemViewState();
  }
}

class _DotMoveItemViewState extends State<DotMoveItemView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
//    _animation = Tween(begin: 0, end: 1.0).animate(_controller);
_animation = CurvedAnimation(parent: _controller, curve: Curves.ease);
    Future(() {
      _controller
        ..addListener(() {
          setState(() {});
        })
        ..addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            if (widget.onComplete != null) widget.onComplete();
          }
        })
        ..forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    Offset sOffset = widget.startOffset ?? Offset(0, 0);
    Offset eOffset = widget.endOffset ?? Offset(0, 0);
    Size sSize = widget.startSize ?? Size(0, 0);
    Size eSize = widget.endSize ?? Size(0, 0);

    double top = sOffset.dy + (eOffset.dy - sOffset.dy) * _animation.value;
    double left = eOffset.dx + (eOffset.dx - sOffset.dx) * _animation.value;

    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: widget.child,
        ),
      ],
    );
  }
}
