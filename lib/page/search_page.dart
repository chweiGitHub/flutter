import 'package:flutter/material.dart';
import 'package:flutter_app/resource/ResIndex.dart';
import 'package:flutter_app/utils/DlgUtil.dart';
import 'package:flutter_app/widget/fade_page_router.dart';
import 'package:flutter_app/widget/scale_page_router.dart';

import 'login_animation_page.dart';





class SearchPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("search"), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.cancel, color: Colors.red, size: 26.0,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ],),
      body: Column(
        children: <Widget>[


          RaisedButton(
            child: Text("login"),
            onPressed: (){
              // 登录成功，开始动画
              Navigator.of(context).push(FadePageRouter(LoginAnimationPage()));
            },
          ),


          Container(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              child: Text("完成"),
              onPressed: (){
//          showConfirmDlg(context, Strings.receiveTaskConfirmInfo, () {
//          });

                showRemindDlg(context);
              },
            ),),
        ],
      ),
    );
  }
}