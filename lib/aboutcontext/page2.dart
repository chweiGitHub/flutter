



import 'package:flutter/material.dart';
import 'package:flutter_app/aboutcontext/global_context.dart';



class Page2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Page1State();
  }



}


class _Page1State extends State<Page2>{

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: Text("context demo"),),
      body:  Column(
        children: <Widget>[
          RaisedButton(
            child: Text("show toast"),
            onPressed: (){
              Scaffold.of(ctx).showSnackBar(SnackBar(content: Text("sample msg")));
            },
          ),
        ],
      ),
    );
  }
}