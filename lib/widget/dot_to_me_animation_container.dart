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
  final List<Widget> children;

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
  }

  @override
  Widget build(BuildContext context) {
    for (var item in widget.children) {
      list.add(DotToMeAnimation(
        child: item,
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

          widget.onComplete();
        },
      ));
    }

    return Stack(
      children: list,
    );
  }
}
