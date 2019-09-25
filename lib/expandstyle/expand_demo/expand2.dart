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
              bottom: 30.0,
              left: 0,
              right: 0,
              child: ExpandView(),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandView extends StatefulWidget {
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
        CurvedAnimation(parent: _controller, curve: Curves.easeOut)
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
    return Container(
      color: Colors.lightBlueAccent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: TitleView(
              key: _titleKey,
            ),
            onTap: () {
              if (canClick) updateExpandedStatus();
            },
          ),
          Stack(alignment: Alignment.center, children: <Widget>[
            Container(
              height: moveDistance,
            ),
            Positioned(
              left: 0,
              right: 0,
              //top: contentTop,
              bottom: contentTop,
              child: ContentView(
                key: _contentKey,
              ),
            ),
          ]),
          GestureDetector(
            child: FooterView(
              key: _footKey,
            ),
            onTap: () {
              if (canClick) updateExpandedStatus();
            },
          ),
        ],
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
      decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )),
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
          color: Colors.deepOrange,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          )),
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
          color: Colors.deepPurpleAccent,
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
