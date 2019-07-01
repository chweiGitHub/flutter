import 'package:flutter/material.dart';
import 'package:flutter_app/bloc_demo/page2.dart';

import 'container.dart';
import 'count_bloc.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CountModel data = ContainerView.of(context);
    return StreamBuilder(
      stream: data.stream,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('page1'),
          ),
          body: Column(
            children: <Widget>[
              TextField(
                cursorWidth: 3.0,
                cursorColor: Colors.red,
                decoration: InputDecoration(
//                  border: UnderlineInputBorder(
//                      borderSide: BorderSide(
//                          color: Colors.red,
//                          width: 1.0,
//                          style: BorderStyle.solid)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                          style: BorderStyle.solid)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                          style: BorderStyle.solid)),
                  //InputBorder(borderSide: BorderSide(color: CustomColors.colorPrimary,width: 1.0)),
                  hintText: "请输1入",
//                      icon: Container(
//                        width: 2.0,
//                        height: 15.0,
//                        color: CustomColors.colorPrimary,
//                      ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      data.increment();
                    },
                    child: Text("+"),
                  ),
                  Text("${snapshot.data}"),
                  RaisedButton(
                    onPressed: () {
                      data.reduce();
                    },
                    child: Text("-"),
                  ),
                ],
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Page2()));
                },
                child: Text("跳转到子页面"),
              ),
            ],
          ),
        );
      },
    );
  }
}
