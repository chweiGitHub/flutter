import 'package:flutter/material.dart';

class MePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MePageState();
  }




}

class _MePageState extends State <MePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("widgets"),),
      body: Center(child: Text("me "),),
    ) ;
  }
}