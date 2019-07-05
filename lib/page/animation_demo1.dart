import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class AnimationPage03 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AnimationPageState();
  }
}


class _AnimationPageState extends State<AnimationPage03> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  CurvedAnimation curve;
  bool isForward = false;
  num pi = 3.1415926;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    animation.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    print("rotate-view--build...");
    return new Scaffold(
        appBar: AppBar(
          title: Text('Animation Demo'),
        ),
        body: Stack(children: <Widget>[
          ListView(children: <Widget>[
            Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(children: <Widget>[
                  Expanded(
                      flex: 1, child: Center(child: Text('FadeTransition'))),
                  Expanded(
                      flex: 1, child: Center(child: Text('ScaleTransition')))
                ])),
            Row(children: <Widget>[
              Expanded(
                  flex: 1,
                  child: FadeTransition(
                      opacity: animation, child: FlutterLogo(size: 100.0))),
              Expanded(
                  flex: 1,
                  child: ScaleTransition(
                      scale: animation, child: FlutterLogo(size: 100.0)))
            ]),
            Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Center(child: Text('RotationTransition'))),
                  Expanded(
                      flex: 1, child: Center(child: Text('AnimatedOpacity')))
                ])),
            Row(children: <Widget>[
              Expanded(
                  flex: 1,
                  child: RotationTransition(
                      turns: animation, child: FlutterLogo(size: 100.0))),
              Expanded(
                  flex: 1,
                  child: AnimatedOpacity(
                      opacity: animation.value,
                      duration: Duration(milliseconds: 2000),
                      child: FlutterLogo(size: 100.0)))
            ]),
            Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Center(child: Text('Transform.translate'))),
                  Expanded(
                      flex: 1, child: Center(child: Text('Transform.rotate')))
                ])),
            Row(children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Transform.translate(
                      offset: Offset(0.0,100.0 * curve.value),
                      child: InkWell(
                        onTap: (){
                          print("测试translate.....");
//                          RenderBox box;
//                          box.localToGlobal(point)
//
//                          RenderObject renderObject = context.findRenderObject();
//                          renderObject.localToGlobal();
//                          Size size = renderObject.paintBounds.size;
//                          Vector3 vector3 = renderObject.getTransformTo(null)?.getTranslation();

                        },
                        child:  FlutterLogo(size: 100.0),
                      ))),
              Expanded(
                  flex: 1,
                  child: Transform.rotate(
                      angle: curve.value * pi, child: FlutterLogo(size: 100.0)))
            ]),
            Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(children: <Widget>[
                  Expanded(
                      flex: 1, child: Center(child: Text('Transform.scale'))),
                  Expanded(flex: 1, child: Center(child: Text('Position')))
                ])),
            Row(children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Transform.scale(
                      scale: curve.value, child: FlutterLogo(size: 100.0))),
            ])
          ]),
          posWid()
        ]),
        floatingActionButton: new FloatingActionButton(
            tooltip: 'Animation',
            child: new Icon(Icons.lightbulb_outline),
            onPressed: () {
              isForward ? controller.reverse() : controller.forward();
              isForward = !isForward;
              RenderBox box = context.findRenderObject();
              Offset offset = box.localToGlobal(Offset.zero);
              print("-======------------------------2222-----------------------------=======> ${offset.dx}---${offset.dy}");

            }));
  }

  Widget posWid() {
    return Positioned(
        top: 16 + 914 * animation.value,
        right: 16 + 84 * animation.value,
        child: Container(child: Icon(Icons.ac_unit, size: 100.0)));
  }
}