import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(StartPage());

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('抽屉效果view'),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                right: 0,
                child: ExpandView(
                  expandViewType: ExpandViewType.EXPAND_TOP_TO_BOTTOM,
                  color: Colors.white,
                  radius: BorderRadius.all(Radius.circular(10.0)),
                ),
                top: 20.0,
              ),
              Positioned(
                left: 0,
                right: 0,
                child: ExpandView(
                  expandViewType: ExpandViewType.EXPAND_BOTTOM_TO_TOP,
                  color: Colors.deepOrange,
                  radius: BorderRadius.all(Radius.circular(10.0)),
                ),
                bottom: 30.0,
              )
            ],
          )),
    );
  }
}

/// 抽屉Widget : 可向上展开，向下展开，上下同时展开
/// todo : titleView,contentView,footView从外部传入
class ExpandView extends StatefulWidget {
  final int expandViewType;
  final BorderRadiusGeometry radius;
  final Color color;
  final Function expandStateChange;
  Widget contentView;
  Widget topView;
  Widget footerView;

  ExpandView(
      {Key key,
      this.expandViewType = ExpandViewType.EXPAND_TOP_TO_BOTTOM,
      this.radius,
      this.color,
      this.expandStateChange,
      this.contentView,
      this.topView,
      this.footerView})
      : super(key: key);

  @override
  _ExpandViewState createState() => _ExpandViewState();
}

class _ExpandViewState extends State<ExpandView>
    with SingleTickerProviderStateMixin {
  double contentTop = 0;
  double contentHeight = 0;
  double moveDistance = 0;
  GlobalKey _titleKey;
  GlobalKey _contentKey;
  GlobalKey _footKey;
  AnimationController _controller;

  Animation _animation;
  bool canClick = true;

  updateExpandedStatus() {
    if (_animation.status == AnimationStatus.dismissed) {
      _controller.forward();
    } else if (_animation.status == AnimationStatus.completed) {
      _controller.reverse();
    }
  }

  @override
  void initState() {
    _titleKey = GlobalKey();
    _contentKey = GlobalKey();
    _footKey = GlobalKey();
    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = //Tween(begin: 0.0, end: 1.0).animate(_controller)
        CurvedAnimation(parent: _controller, curve: Curves.easeIn)
          ..addListener(() {
            setState(() {
              moveDistance = contentHeight * _animation.value;
              contentTop = 0 - contentHeight + moveDistance;
            });
          })
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.forward ||
                status == AnimationStatus.reverse) {
              setState(() {
                canClick = false;
              });
            } else {
              setState(() {
                canClick = true;
              });
            }
          });
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBoxContent =
          _contentKey.currentContext.findRenderObject();
      contentHeight = renderBoxContent.size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget contentView = widget.contentView ??
        Container(
          child: Text("content"),
          color: Colors.redAccent,
          height: 100,
        );
    Widget topView = widget.topView ??
        Container(
          alignment: Alignment.center,
          child: Text("header"),
          color: Colors.lightBlue,
          height: 30,
        );
    Widget footerView = widget.footerView ??
        Container(
          alignment: Alignment.center,
          child: Text("footer"),
          color: Colors.lightBlue,
          height: 30,
        );
    Widget contentSubView;
    if (widget.expandViewType == ExpandViewType.EXPAND_TOP_TO_BOTTOM) {
      contentSubView = Positioned(
        left: 0,
        right: 0,
        top: contentTop,
        child: Container(
          key: _contentKey,
          child: contentView,
        ),
      );
    } else if (widget.expandViewType == ExpandViewType.EXPAND_BOTTOM_TO_TOP) {
      contentSubView = Positioned(
        left: 0,
        right: 0,
        bottom: contentTop,
        child: Container(
          key: _contentKey,
          child: contentView,
        ),
      );
    } else {
      contentSubView = Positioned(
        left: 0,
        right: 0,
        child: Container(
          key: _contentKey,
          child: contentView,
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        if (!canClick) return;
        updateExpandedStatus();
        if (widget.expandStateChange != null) {
          widget.expandStateChange();
        }
      },
      child: Container(
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: widget.color ?? Colors.transparent,
          borderRadius: widget.radius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              key: _titleKey,
              child: Center(child: topView),
              alignment: Alignment.center,
            ),
            Stack(alignment: Alignment.center, children: <Widget>[
              Container(
                height: moveDistance,
              ),
              contentSubView,
            ]),
            Container(
              key: _footKey,
              child: footerView,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animation = null;
    super.dispose();
  }
}

class ExpandViewType {
  static const int EXPAND_TOP_TO_BOTTOM = 1;
  static const int EXPAND_BOTTOM_TO_TOP = 2;
}

class TitleView extends StatelessWidget {
  TitleView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
      ),
      child: Text("title"),
      decoration: BoxDecoration(),
    );
  }
}

class FooterView extends StatelessWidget {
  FooterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
      ),
      child: Text("footer"),
      decoration: BoxDecoration(
//        color: Colors.deepOrange,
//        borderRadius: BorderRadius.only(
//          bottomLeft: Radius.circular(20.0),
//          bottomRight: Radius.circular(20.0),
//        ),
          ),
    );
  }
}

class ContentView extends StatelessWidget {
  ContentView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
//          color: Colors.deepPurpleAccent,
          alignment: Alignment.topCenter,
          child: Text("content1"),
        ),
        Text("content2"),
        Text("content3"),
        Text("content4"),
        Text("content5"),
        Text("content6"),
        Text("content8"),
        Text("content9"),
      ],
    );
  }
}
