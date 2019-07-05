import 'package:flutter/material.dart';



class SizeButton extends StatelessWidget{
  SizeButton({Key  key, this.child, this.onPressed}):super(key : key);
  final Widget child;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.lightGreenAccent,
      child: child,
      onPressed: (){
        RenderBox box = context .findRenderObject();
        onPressed(box);
      },
    );
  }
}