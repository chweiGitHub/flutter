
import 'package:flutter/material.dart';
import 'package:flutter_app/paint/page1.dart';


void main ()=> runApp(MainPage()); 

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: 
//      Image.asset("assets/images/food06.jpeg")
      Page1(),
    );
  }
}
