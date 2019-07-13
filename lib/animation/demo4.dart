import 'package:flutter/material.dart';

import 'dynamic_shape_size_view.dart';

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
  Animation animation;
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
    controller.addListener(() {
      print("----->>>>> ${animation.value}");
      setState(() {});
    });
    curved = new CurvedAnimation(
        parent: controller, curve: Curves.bounceOut); //模仿小球自由落体运动轨迹

    animation = Tween(begin: 1.0, end: 10.0).animate(controller);

//    controller.forward();//放在这里开启动画 ，打开页面就播放动画
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('FadeTest'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: CustomPaint(
                painter: DynamicShapeView(15 * animation.value),
              ),
              onTap: () {
                controller.forward();
              },
            ),
          ],
//        child: new FadeTransition(//透明度动画
//          opacity: curved,//将动画传入不同的动画widget
//          child: new FlutterLogo(//创建一个小部件，用于绘制Flutter徽标
//            size: 200.0,
//          ),
//        ),
        ),
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
