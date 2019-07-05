import 'package:flutter/material.dart';

/*
 * 领取成功后 任务加到我页面动画
 */
class DotToMeAnimation extends StatefulWidget {
  DotToMeAnimation(
      {Key key,
      @required this.child,
      @required this.startOffset,
      @required this.endOffset,
      this.startSize,
      this.endSize,
      this.onComplete})
      : super(key: key);
  final Offset startOffset;

  final Offset endOffset;

  final Size startSize;
  final Size endSize;

  final Widget child;

  Function onComplete;

  @override
  State<StatefulWidget> createState() {
    return _DotToMeAnimationState();
  }
}

class _DotToMeAnimationState extends State<DotToMeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    // 初始化动画相关
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // 动画完成
          if (widget.onComplete != null) widget.onComplete();
        }
      })
      ..addListener(() {
        setState(() {});
      });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 页面渲染完成后 开始动画
      print("页面渲染完成后 开始动画");
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
//    return Transform.translate(offset: getOffset(), child: widget.child,);

    Size startSize = widget.startSize == null ? Size(0, 0) : widget.startSize;
    Size endSize = widget.endSize == null ? Size(0, 0) : widget.endSize;

    num startX = widget.startOffset.dx  + startSize.width / 2 - 10.0;
    num startY = widget .startOffset.dy + startSize.height / 2 - 10.0;

    num endX = widget.endOffset.dx  + endSize.width / 2;
    num endY = widget .endOffset.dy + endSize.height / 2;


    num x = endX - startX ;
    num y = endY - startY;

    if(widget.startSize != null){
      print("========================= startSize: ${widget.startSize} --- ${widget.startSize.width / 2}");
    }
    num top  = startY + y * _animation.value;
    num left = startX + x * _animation.value;
//
//    num top = widget.startOffset.dy +
//        y * _animation.value +
//        (widget.startSize == null ? 0 : widget.startSize.height / 2 - 10.0);
//    num left = widget.startOffset.dx +
//        x * _animation.value +
//        (widget.startSize == null ? 0 : widget.startSize.width / 2 - 10.0);

    return Positioned(
      top: top,
      // top: _getOffset().dy + widget.defferentY * (1 - _animation.value),
      left: left,
//      height: _getstartSize().height * _animation.value,
//      width: _getstartSize().width * _animation.value,
      child: Opacity(
        opacity: (1 - _animation.value),
        child: widget.child,
      ),
    );
  }

  Offset getOffset() {
    if (widget.startOffset == null || widget.endOffset == null)
      return Offset(0, 0);
    return Offset(
        widget.startOffset.dx + widget.endOffset.dx * _animation.value,
        widget.startOffset.dy + widget.endOffset.dy * _animation.value);
  }
}
