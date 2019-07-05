import 'package:flutter/material.dart';

class PositionContainer extends StatefulWidget {


  PositionContainer({Key key, this.child, this.onTap}):super(key:key);
  final Widget child;
Function onTap;
  @override
  _PositionContainerState createState() => _PositionContainerState();
}

class _PositionContainerState extends State<PositionContainer>
    with WidgetsBindingObserver {

  void _onAfterRendering(Duration timeStamp) { print("_onAfterRendering_onAfterRendering_onAfterRendering_onAfterRendering");
    RenderObject renderObject = context.findRenderObject(); //获取元素大小
    Size size = renderObject.paintBounds.size; //获取元素位置
    var vector3 = renderObject.getTransformTo(null)?.getTranslation();
//    CommonUtils.showChooseDialog(context, size, vector3);

    print("在屏幕上的坐标为： ${size.width}, ${size.height}");
  }

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: (){
        RenderObject renderObject = context.findRenderObject(); //获取元素大小
        Size size = renderObject.paintBounds.size; //获取元素位置
        var vector3 = renderObject.getTransformTo(null)?.getTranslation();
//    CommonUtils.showChooseDialog(context, size, vector3);

        print("在屏幕2222上的坐标为： ${size.width}, ${size.height}");

        widget.onTap();
      },
      child: widget.child,
    );
  }
}
