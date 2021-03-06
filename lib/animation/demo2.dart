import 'package:flutter/material.dart';

void main() {
  runApp(new FadeAppTest());
}

class FadeAppTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fade Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyFadeTest(title: 'Fade Demo'),
    );
  }
}

class MyFadeTest extends StatefulWidget {
  MyFadeTest({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State createState() => new _MyFadeTest();
}

class _MyFadeTest extends State<MyFadeTest> with TickerProviderStateMixin {
  AnimationController controller; //动画控制器
  CurvedAnimation curved; //曲线动画，动画插值，
  bool forward = true;

  @override
  void initState() {
    //初始化，当当前widget被插入到树中时调用
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 3));
    controller.addStatusListener((AnimationStatus status) {
      print("addStatusListener---repeat.......$status");
      if (status == AnimationStatus.completed) {
        print("repeat.......");
        controller.repeat();
      }
    });
    curved = new CurvedAnimation(
        parent: controller, curve: Curves.bounceOut); //模仿小球自由落体运动轨迹
//    controller.forward();//放在这里开启动画 ，打开页面就播放动画
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('FadeTest'),
      ),
      body: new Column(
        children: <Widget>[
//          AnimatedCrossFade(
//            duration: const Duration(seconds: 3),
//            firstChild: const FlutterLogo(
//                style: FlutterLogoStyle.horizontal, size: 100.0),
//            secondChild:
//                const FlutterLogo(style: FlutterLogoStyle.stacked, size: 100.0),
//            crossFadeState:
//                _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
//          ),
          new RotationTransition(
            //旋转动画
            turns: new Tween(begin: 0.0, end: 3.0).animate(controller),
            child: new FlutterLogo(
              size: 200.0,
            ),
          ),
        ],
//        child: new FadeTransition(//透明度动画
//          opacity: curved,//将动画传入不同的动画widget
//          child: new FlutterLogo(//创建一个小部件，用于绘制Flutter徽标
//            size: 200.0,
//          ),
//        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          if (forward)
            controller.forward(); //向前播放动画
          else
            controller.reverse(); //向后播放动画
          forward = !forward;
        },
        tooltip: 'fade',
        child: new Icon(Icons.track_changes),
      ),
    );
  }
}
