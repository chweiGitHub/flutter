import 'dart:math';

import 'package:flutter/material.dart';

class DynamicShapeView extends CustomPainter {
  Paint _paint;

  double r;

  DynamicShapeView(this.r) {
    _paint = Paint()
      ..color = Colors.yellowAccent
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    r = r > 60 ? 60 : r;
    canvas.drawPath(nStarPath(5, r, 30), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  /*
   * n角星路径
   *
   * @param num 几角星
   * @param R   外接圆半径
   * @param r   内接圆半径
   * @return n角星路径
   */
  Path nStarPath(int num, double R, double r) {
    Path path = new Path();
    double perDeg = 360 / num; //尖角的度数
    double degA = perDeg / 2 / 2;
    double degB = 360 / (num - 1) / 2 - degA / 2 + degA;

    path.moveTo(cos(_rad(degA)) * R, (-sin(_rad(degA)) * R));
    for (int i = 0; i < num; i++) {
      path.lineTo(
          cos(_rad(degA + perDeg * i)) * R, -sin(_rad(degA + perDeg * i)) * R);
      path.lineTo(
          cos(_rad(degB + perDeg * i)) * r, -sin(_rad(degB + perDeg * i)) * r);
    }
    path.close();
    return path;
  }

  double _rad(double deg) {
    return deg * pi / 180;
  }
}
