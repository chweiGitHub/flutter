import 'package:flutter/material.dart';
import 'package:flutter_app/widget/dot_to_me_animation.dart';

/*
 * 领取成功后 任务加到我页面动画
 */
class DotToMeAnimationContainer extends StatefulWidget {
  DotToMeAnimationContainer({
    Key key,
    @required this.children,
    @required this.startOffset,
    @required this.endOffset,
    this.startSize,
    this.endSize,
    this.onComplete,
  }) : super(key: key);
  final Offset startOffset;
  final Offset endOffset;
  final Size startSize;
  final Size endSize;
  final Function onComplete;
//  final List<Widget> children;
    Widget children;

  @override
  State<StatefulWidget> createState() {
    return _DotToMeAnimationContainerState();
  }
}

class _DotToMeAnimationContainerState extends State<DotToMeAnimationContainer> {
  var list = <Widget>[];

  @override
  void initState() {
    super.initState();
    print("DotToMeAnimationContainer--- initState   ");
  }

  @override
  void didUpdateWidget(DotToMeAnimationContainer oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("DotMoveView---- didUpdateWidget");
    if(widget.children != null){
      list.add(DotToMeAnimation(
          child: widget.children,
          startOffset: widget.startOffset,
          endOffset: widget.endOffset,
          startSize: widget.startSize,
          endSize: widget.endSize,
          onComplete: () {
            print("动画结束，移除wiget ....");
            if (list.length > 0) {
              list.remove(0);
              //setState(() {});
            }

            if (widget.onComplete != null) widget.onComplete();
          }
      ));
    }
  }


  @override
  Widget build(BuildContext context) {

    print("-----> list.size: ${list.length}");
//    for (var item in widget.children) {
//      list.add(DotToMeAnimation(
//        child: item,
//        startOffset: widget.startOffset,
//        endOffset: widget.endOffset,
//        startSize: widget.startSize,
//        endSize: widget.endSize,
//        onComplete: () {
//          print("动画结束，移除wiget ....");
//          if (list.length > 0) {
//            list.remove(0);
//            //setState(() {});
//          }
//
//          if (widget.onComplete != null) widget.onComplete();
//        },
//      ));
//    }

    return Stack(
      children: list,
    );
  }
}
