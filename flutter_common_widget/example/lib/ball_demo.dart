import 'package:flutter/material.dart';
import 'package:flutter_common_widget/ball/ball.dart';




class BallDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("球体 demo"),),
      body: BallView (count: 100,),
    );
  }
}
