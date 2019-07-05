import 'package:flutter/material.dart';

class BaseTechnologyPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BaseTechnologyPageState();
  }




}

class _BaseTechnologyPageState extends State <BaseTechnologyPage>{
  GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("widgets"),),
      body: Column(
        children: <Widget>[

          Container(
            key: _key,
            child: RaisedButton(onPressed: (){
              RenderBox renderBox = context.findRenderObject();
              Offset offset =  renderBox.localToGlobal(Offset.zero);
              print("---${offset.dx}----${offset.dy}");

              RenderBox renderBox2 = _key.currentContext.findRenderObject();
              Offset offset2 =  renderBox2.localToGlobal(Offset.zero);
              print("--22-${offset2.dx}----${offset2.dy}");

              double _statusBarHeight = MediaQuery.of(context).padding.top;
              print("状态栏的高度： $_statusBarHeight");
            },
            child: Text("click..."),),
          ),
        ],
      ),
    ) ;
  }
}