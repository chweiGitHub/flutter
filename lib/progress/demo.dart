import 'package:flutter/material.dart';

main() => runApp(StartPage());

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("progress demo"),
      ),
      body: Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CLineProgress(),
                      Container(
                        child: Text("测试一下"),
                      ),
                    ],
                  ),
                  Container(
                    height: 50.0,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 300,
                        child: CLineProgress(),
                      ),
                    ],
                  ),
//              Row(
//                children: <Widget>[
//                  Expanded(
//                    child: SizedBox(
//                      height: 20.0,
//                      child: CustomPaint(
//                        painter: Test(),
//                      ),
//                    ),
////                      decoration: BoxDecoration(
////                        borderRadius: BorderRadius.all(Radius.circular(100.0))
////                      ),
//                  ),
//                ],
//              ),
                ],
              )),
        ],
      ),
    );
  }
}

class CLineProgress extends StatefulWidget {
  final double height;
  final Color bgColor;
  final Color color;
  final double radius;
  final bool withAnimation;
  final double progress;

  const CLineProgress(
      {Key key,
      this.height = 10.0,
      this.bgColor = const Color(0xFFBDBDBD),
      this.color = Colors.orange,
      this.radius = 10.0,
      this.withAnimation = true,
      this.progress = 0.7})
      : super(key: key);

  @override
  _CLineProgressState createState() => _CLineProgressState();
}

class _CLineProgressState extends State<CLineProgress>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    if (widget.withAnimation) {
      _controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 600));
      _animation = CurveTween(curve: Curves.easeIn).animate(_controller)
        ..addStatusListener((AnimationStatus status) {})
        ..addListener(() {
          setState(() {});
        });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller?.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animation = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double p = widget.progress * (_animation == null ? 1 : _animation.value);
    print("P: $p");

    return Container(
      alignment: Alignment.centerLeft,
      child: CustomPaint(
        size: Size(100, 10.0),
        painter: ProgressPainter(
          height: widget.height,
          bgColor: widget.bgColor,
          color: widget.color,
          radius: widget.radius,
          progress: p,
        ),
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final double height;
  final Color bgColor;
  final Color color;
  final double radius;
  final double progress;

  Paint _paint;
  Paint _paint2;

  ProgressPainter({
    this.height,
    this.bgColor,
    this.color,
    this.radius,
    this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _paint = Paint()
      ..color = bgColor //画笔颜色
      ..isAntiAlias = true //是否启动抗锯齿
      ..strokeWidth = 1.0; //画
    _paint2 = Paint()
      ..color = color //画笔颜色
      ..isAntiAlias = true //是否启动抗锯齿
      ..strokeWidth = 1.0;

    _paint.strokeWidth = height;
    _paint2.strokeWidth = height;

    print("---------size-w: ${size.width},h:${ height}");

    double radius = 10;
    canvas.clipRRect(
        RRect.fromLTRBXY(0, 0, size.width,  height, radius, radius));
    canvas.drawRRect(
        RRect.fromLTRBXY(0, 0, size.width, height, radius, radius),
        _paint);
    Radius rLeft = Radius.circular(radius);
    Radius rRight = Radius.circular(0);
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(0, 0, progress * size.width,  height,
            topLeft: rLeft,
            bottomLeft: rLeft,
            topRight: rRight,
            bottomRight: rRight),
        _paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
