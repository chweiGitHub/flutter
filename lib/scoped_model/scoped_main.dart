import 'package:flutter/material.dart';
import 'package:flutter_app/scoped_model/page1.dart';
import 'package:flutter_app/scoped_model/user_info_model.dart';
import 'package:scoped_model/scoped_model.dart';

void main()=> runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return ScopedModel(
      model: UserInfoModel(),
      child: MaterialApp(
        title:"scoped",
        home: Scaffold(
          appBar: AppBar(title: Text("scoped-page1"),),
          body: Page1()
        ),
      ),
    );
  }

}