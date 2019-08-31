import 'package:flutter/material.dart';


void main() =>
    runApp(
        StartPage()
    );

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestPage(),
    );
  }
}


class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("flutter 绘制demo"),),
      body: CustomPaint(foregroundPainter: PaintDemo(),),
    );
  }
}

class PaintDemo extends CustomPainter {
  Paint _paint;

  PaintDemo() {
    _paint = Paint()
      ..color = Colors.orange // 画笔的颜色
      ..strokeWidth = 2.0 // 线的宽度
      ..style = PaintingStyle.fill // fill: 填充， stroke: 空心
    ;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(10, 10), Offset(60, 10), _paint);

    canvas.drawCircle(Offset(100, 100), 50, _paint);

    Size size = Size(200, 300);
    // 可以通过Offset和Size来创建一个Rect，Offset 决定他右上角的坐标    Size 决定他的大小
    Rect rect = Offset(200, 200) & size;
    canvas.drawRect(
        rect,
        Paint()
          ..color = Colors.red
          ..strokeWidth = 3.0);

    // 绘制阴影
    canvas.drawShadow(
        Path()
          ..moveTo(30.0, 500.0)
          ..lineTo(320.0, 500.0)..lineTo(120.0, 660.0)..lineTo(30.0, 660.0)
          ..close(),
        Colors.blue,
        3,
        false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
