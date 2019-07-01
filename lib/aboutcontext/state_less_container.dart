import 'package:flutter/material.dart';

class StatelessContainer extends StatefulWidget{
  StatelessContainer({Key key}):super(key:key);
@override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State <StatelessContainer>{
  Color getColor (){
    return Colors.lightBlue;
  }

  final String value =  DateTime.now().toString();
  @override
  Widget build(BuildContext context) {
    return  Text(
     value,
    );
  }
}