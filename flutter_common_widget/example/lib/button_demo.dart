import 'package:flutter/material.dart';
import 'package:flutter_common_widget/button/button.dart';
import 'package:flutter_common_widget/utils/index.dart';

class ButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> views = <Widget>[
      InkWell(
        focusColor: Colors.lightBlue,
        highlightColor: Colors.deepOrange,
        onTap: () {
          showCenterRemindDlg(context, "你点我了");
        },
        splashColor: Colors.green,
        hoverColor: Colors.orange,
        child: Container(
          //alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),
          child: Text("水波纹效果按钮"),
        ),
      ),
      CustomCircleLeftRightButton(
        onPress: () {
          showCenterRemindDlg(context, "你点我了");
        },
      ),
      CustomCircleLeftRightButton(
        child: "按钮",
        bgColor: Colors.red,
        onPress: () {
          showCenterRemindDlg(context, "你点我了");
        },
      ),
      CustomButton(
        "按钮",
        onPress: () {
          showCenterRemindDlg(context, "你点我了");
        },
      ),
      CustomButton(
        Text(
          "按钮",
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.green,
        ),
        onPress: () {
          showCenterRemindDlg(context, "你点我了");
        },
      ),
      CustomButton(
        Container(
          alignment: Alignment.center,
          child: Text(
            "按钮",
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
          width: 40.0,
          height: 40.0,
        ),
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.green,
        ),
        onPress: () {
          showCenterRemindDlg(context, "你点我了");
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("常用按钮 demo"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: views,
        ),
      ),
    );
  }
}
