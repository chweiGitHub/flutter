import 'package:flutter/material.dart';

import 'ball.dart';


void main ()=> runApp (MainPage ()) ;


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("ball demo"),),
        body: BallView(count: 50,),
      ),
    );
  }
}
