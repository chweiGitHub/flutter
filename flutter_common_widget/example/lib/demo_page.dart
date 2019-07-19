import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget {
  final String showInfo;

  const DemoPage({Key key, this.showInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("demo page"),
      ),
      body: Container(
        color: Colors.deepOrange,
        alignment: Alignment.center,
        child: Text(showInfo ?? "---"),
      ),
    );
  }
}
