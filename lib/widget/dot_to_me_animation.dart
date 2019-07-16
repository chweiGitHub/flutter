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
    with TickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _curvedAnimation;
  Animation _animation;
  AnimationController _scaleController;
  Animation _scaleAnimation;
  AnimationController _opacityController;
  Animation _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // -- 初始化动画相关
    // 从小到大 动画
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 220));
    _scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(_scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // 动画完成
          _scaleAnimation= Tween(begin: 1.0, end: 0.3).animate(_controller)
            ..addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                // 动画完成
              }
            })
            ..addListener(() {
              setState(() {});
            });
          _controller.forward();
        }
      })
      ..addListener(() {
        setState(() {});
      });
    // 移动动画
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // 动画完成
              _opacityController.forward();
            }
          })
          ..addListener(() {
            setState(() {});
          });
    // 显示到隐藏动画
    _opacityController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 220));
    _opacityAnimation = Tween(begin: 1.0, end: 0.0).animate(_opacityController)
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
      _scaleController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size startSize = widget.startSize == null ? Size(0, 0) : widget.startSize;
    Size endSize = widget.endSize == null ? Size(0, 0) : widget.endSize;

    num startX = widget.startOffset.dx + startSize.width / 2 - 10.0;
    num startY = widget.startOffset.dy + startSize.height / 2 - 10.0;

    num endX = widget.endOffset.dx + endSize.width / 2;
    num endY = widget.endOffset.dy + endSize.height / 2;

    num x = endX - startX;
    num y = endY - startY;

    num top = startY + y * _curvedAnimation.value;
    num left = startX + x * _curvedAnimation.value;


    return Positioned(
      top: top,
      left: left,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Opacity(
          opacity: _opacityAnimation.value,
          child: widget.child,
        ),
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

  @override
  void dispose() {
    _controller.dispose();
    _scaleController.dispose();
    _opacityController.dispose();
    super.dispose();
  }
}
