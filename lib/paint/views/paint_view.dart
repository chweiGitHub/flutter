import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui' as dartUi;
import 'dart:ui';

import 'package:flutter/services.dart';

import '../UIImageLoader.dart';

class PaintViewCustomer extends CustomPainter {
  Paint p;

  dartUi.Image image;

  PaintViewCustomer(dartUi.Image image) {
    this.image = image;
    p = Paint()
      ..color = Colors.orange // 画笔的颜色
      ..strokeWidth = 2.0 // 线的宽度
      ..style = PaintingStyle.stroke // fill: 填充， stroke: 空心
//      ..strokeCap = StrokeCap.butt // 转折处的处理
//      ..blendMode = BlendMode.dstIn
    ; // 重叠处的处理模式，clear,src, dst, srcIn,dstIn等等。

//    BlendMode.clear;  // 都清除
//    BlendMode.src; // 只显示源图
//    BlendMode.dst; // 只显示目标图
//    BlendMode.srcOver; // 都显示，重叠部分是src覆盖在dst的上边；
//    BlendMode.dstOver; // 都显示，重叠部分是dst覆盖在src的上边；
//    BlendMode.srcIn; // 只显示重叠部分的src图，透明部分也是不显示的。
//    BlendMode.dstIn; // 只显示重叠部分的dst图，透明部分也是不显示的。，
//    srcOver：默认值。将src与dst进行组合，如果src和dst有重叠的地方，则以src内容覆盖与dst重叠的地方。
  }

  @override
  Future paint(Canvas canvas, Size size) {
    // 画线
    canvas.drawLine(Offset(10, 10), Offset(100, 100), p);
    // 画一个圆
    canvas.drawCircle(Offset(100, 100), 50, p);

    // 绘制多边形
    canvas.drawPath(
        Path()
          ..moveTo(30, 200)
          ..lineTo(200, 200)
          ..lineTo(100, 300)
          ..lineTo(50, 330)
          ..lineTo(30, 300)
          ..close(),
        Paint()
          ..color = Colors.lightBlue
          ..strokeWidth = 1.0);

    // 画一个矩形
    Size size = Size(200, 300);
    // 可以通过Offset和Size来创建一个Rect，Offset 决定他右上角的坐标    Size 决定他的大小
    Rect rect = Offset(200, 200) & size;
    canvas.drawRect(
        rect,
        Paint()
          ..color = Colors.red
          ..strokeWidth = 3.0);
//
//    // 画一个Image   TODO 绘制的时候一直有异常。。。 暂时找不到原因 :  一直绘制异常是由于加载图片是异步的，需要时间。提前加载好，再绘制就不会有问题。
//    print("开始绘制");
////    ImageLoader.load("assets/images/xiaomi.jpg").then((image){
////   //   canvas.drawImage(image, Offset(500, 213), p);
////
////      canvas.drawImage(image, dartUi.Offset(60.0, 540.0), Paint());
//      canvas.drawImageRect(
//          image,
//          Rect.fromLTWH(0, 0, 60, 60),
//          Rect.fromLTWH(60, 60, image.width.toDouble(), image.height.toDouble()),
//          Paint());
////
////    });
//    if (image != null) {
//      // 绘制的是一个完整的图
//      canvas.drawImage(
//          // 要绘制的图
//          image,
//          // 要绘制的右上角的坐标
//          dartUi.Offset(60.0, 60.0),
//          // 画笔
//          p);
//
//    canvas.drawImage(
//        image, dartUi.Offset(0, image.height.toDouble() + 30), Paint());
//    canvas.drawImageRect(
//        image,
//        // 本次要截取的区域--相对于原图（该坐标以原图的左上角为原点0，0）
//        Rect.fromLTWH(60, 60, image.width.toDouble(), image.height.toDouble()),
//        // 要被截取的原图所在的区域
//        Rect.fromLTWH(60, 60, image.width.toDouble(), image.height.toDouble()),
//        Paint());
//      canvas.drawImageNine(
//          image,
//          Rect.fromLTWH(0, 0, 120, 60),
//          Rect.fromLTWH(
//              60, 1020, image.width.toDouble() - 120, image.height.toDouble()),
//          Paint());

    // 绘制阴影
    canvas.drawShadow(
        Path()
          ..moveTo(30.0, 300.0)
          ..lineTo(320.0, 300.0)
          ..lineTo(120.0, 560.0)
          ..lineTo(30.0, 560.0)
          ..close(),
        Colors.blue,
        3,
        false);

    // 绘制文本
    ParagraphBuilder pb = ParagraphBuilder(ParagraphStyle(
      textAlign: TextAlign.left, // 对齐方式
      fontWeight: FontWeight.w600, // 粗体
      fontStyle: FontStyle.normal, // 正常 or 斜体
      fontSize: 18,
    ))
      ..pushStyle(dartUi.TextStyle(color: Colors.black26))
      ..addText('''
      // 测试文本的绘制
      // 绘制阴影
      canvas.drawShadow(
        Path()
          ..moveTo(30.0, 30.0)
          ..lineTo(320.0, 30.0)
          ..lineTo(120.0, 160.0)
          ..lineTo(30.0, 160.0)
          ..close(),
        Colors.blue,
        3,
        false);
          ''');
    // 绘制的宽度
    ParagraphConstraints pc =
        ParagraphConstraints(width: 350.0);
    Paragraph paragraph = pb.build()..layout(pc);
    canvas.drawParagraph(paragraph, Offset(30, 600));
//
//    // 保存当前画布
//    canvas.save();
//    // 裁剪 clip
//    canvas.clipRect(Rect.fromLTWH(60, 60, 190, 90));
//
//    canvas.drawImage(
//        // 要绘制的图
//        image,
//        // 要绘制的右上角的坐标
//        dartUi.Offset(60.0, 60.0),
//        // 画笔
//        p);
//
//    // 恢复之前的画布， 避免裁剪对后边绘制的影响
//    canvas.restore();
//    canvas.drawPath(
//        Path()
//          ..moveTo(30, 200)
//          ..lineTo(200, 200)
//          ..lineTo(100, 300)
//          ..lineTo(50, 330)
//          ..lineTo(30, 300)
//          ..close(),
//        Paint()
//          ..color = Colors.lightBlue
//          ..strokeWidth = 1.0);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
