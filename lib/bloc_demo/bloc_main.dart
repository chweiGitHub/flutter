

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc_demo/page1.dart';

import 'container.dart';



void main (){
  runApp(MyApp ());
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  ContainerView (
      child: MaterialApp(
        title:"bloc",
        theme: ThemeData.light(),
        home: Page1(),
      )
    );
  }

}