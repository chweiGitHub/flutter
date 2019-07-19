import 'package:flutter/material.dart';

class SizeButton extends StatelessWidget {

  final Function press ;

  const SizeButton({Key key, this.press}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add, color: Colors.red,),
      onPressed: (){
        RenderBox renderBox = context.findRenderObject();
//        Offset offset = renderBox.localToGlobal(Offset.zero);
//        Size size = renderBox.size;
      press(renderBox);
      },
    );
  }
}
