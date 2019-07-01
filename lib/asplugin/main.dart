import 'package:custom_plugin/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/toast/customtoast/global_context.dart';
import 'package:flutter_app/toast/customtoast/page1.dart';

void main() {
  return runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("toast demo"),
        ),
        body: Demo(),
      ),
    );
  }
}

class Demo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DemoState();
  }
}

class _DemoState extends State<Demo> {
  List<Widget> list = [
    Text("""
    Flutter是谷歌的移动UI框架，可以快速在iOS和Android上构建高质量的原生用户界面。 Flutter可以与现有的代码一起工作。在全世界，Flutter正在被越来越多的开发者和组织使用，并且Flutter是完全免费、开源的。
    """),
    RaisedButton(
      child: Text("显示Android原生Toast"),
      onPressed: (){
        cPrint("显示Android原生Toast");
        showAndroidToast("我是Android的Toast");
      },
    ),
  ];

  @override
  void initState() {
    super.initState();

    GlobalContext.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: list,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
//        list.insert(0, list.removeAt(1));
//        setState(() {});
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Page1()));
      }),
    );
  }
}
