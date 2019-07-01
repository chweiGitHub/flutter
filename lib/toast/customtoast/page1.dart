



import 'package:custom_plugin/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/toast/customtoast/global_context.dart';
import 'package:flutter_app/toast/customtoast/toast.dart';
import 'package:flutter_app/toast/customtoast/page2.dart';




class Page1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Page1State();
  }



}


class _Page1State extends State<Page1>{

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: Text("context demo"),),
      body:  Column(
        children: <Widget>[
          RaisedButton(
            child: Text("跳转"),
            onPressed: (){
//              Scaffold.of(ctx).showSnackBar(SnackBar(content: Text("sample msg")));
            showToast ("跳转到page2");
            cPrint("跳转到Page2");
            Navigator.of(GlobalContext.context).push(MaterialPageRoute(builder: (context)=> Page2()));
            },
          ),
        ],
      ),
    );
  }
}