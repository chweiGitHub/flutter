import 'package:flutter/material.dart';



void main ()=> runApp (StartPage ());


class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

      MaterialApp (
      home: FirstPage (),
    );
  }
}
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[

      ],),
    );
  }
}

