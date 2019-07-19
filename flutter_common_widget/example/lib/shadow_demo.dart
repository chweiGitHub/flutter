import 'package:flutter/material.dart';
import 'package:flutter_common_widget/shadow/shadow_container.dart';

class ShadowDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> views = <Widget>[
      ShadowContainer(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          width: 100.0,
          height: 80.0,
          child: Text("0123456789"),
        ),
        shadowColor: Colors.grey,
        blurRadius: 2.0,
        spreadRadius: 0.2,
      ),
      Container(
        height: 30.0,
      ),
      ShadowContainer(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          width: 100.0,
          height: 80.0,
          child: Text("0123456789"),
        ),
        shadowColor: Colors.grey,
        blurRadius: 6.0,
      ),
      Container(
        height: 30.0,
      ),
      ShadowContainer(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          width: 100.0,
          height: 80.0,
          child: Text("0123456789"),
        ),
        shadowColor: Colors.black,
        blurRadius: 12.0,
      ),
      Container(
        height: 30.0,
      ),
      ShadowContainer(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          width: 100.0,
          height: 80.0,
          child: Text("0123456789"),
        ),
        shadowColor: Colors.black,
      ),
      Container(
        height: 30.0,
      ),
      ShadowContainer(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          width: 100.0,
          height: 80.0,
          child: Text("0123456789"),
        ),
        shadowColor: Colors.black,
        blurRadius: 30.0,
        spreadRadius: 0.8,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("阴影 demo"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: views,
        ),
      ),
    );
  }
}
