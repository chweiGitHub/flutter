

import 'package:flutter/material.dart';
import 'package:flutter_app/widget/size_button.dart';



class ItemView extends StatefulWidget{
  ItemView({Key key, this.value, this.onPress}):super(key : key);

  String value ; Function onPress ;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ItemViewState();
  }
}

class _ItemViewState extends State<ItemView>{

  GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[

          Text("${widget.value}"),


        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              key: _key,
              child: Text("receive"),
              onPressed: (){
                RenderBox box =  /*_key.currentContext*/context.findRenderObject();
                Offset offset = box.localToGlobal(Offset.zero);
                print("-======-----------------------------------------------------=======> ${offset.dx}---${offset.dy}-----");
                //widget.onPress (offset.dx, offset.dy) ;
              },
            ),


//            GestureDetector(
//              child:
              SizeButton(
                child: Text("receive"),
                onPressed:  (RenderBox box) {
//                  RenderBox box = context.findRenderObject();
                  Offset offset = box.localToGlobal(Offset.zero);
                  Size size = box.size;
                  print("-======------------------------2222-----------------------------=======> ${offset.dx}---${offset.dy}------");
                  widget.onPress(offset, size);
                },
              ),
//              onTap: () {
//                RenderBox box = context.findRenderObject();
//                Offset offset = box.localToGlobal(Offset.zero);
//                print("-======------------------------2222-----------------------------=======> ${offset.dx}---${offset.dy}------");
//              },
//            ),

          ],
        ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    print("dispose------------------------>  ${widget.value} <------------------------" );
    super.dispose();

  }
}