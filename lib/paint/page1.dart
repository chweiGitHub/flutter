import 'package:flutter/material.dart';

import 'UIImageLoader.dart';
import 'views/paint_view.dart';

import 'dart:ui' as ui;

class Page1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<Page1> {
  ui.Image image;

  @override
  void initState() {
    super.initState();
    ImageLoader.load("assets/images/food05.jpeg").then((ui.Image data) {
      setState(() {
        image = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("image==null ${image == null}");
    return Scaffold(
      appBar: AppBar(
        title: Text("paint demo"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            CustomPaint(
              child: Container(
                alignment: Alignment(200, 200),
                child: Text("测试一下。。。"),),
              painter: null,
              foregroundPainter: PaintViewCustomer(image),
            ),
          ],
        ),
      ),
    );
  }
}
