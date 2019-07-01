import 'package:flutter/material.dart';
import 'package:flutter_app/aboutcontext/global_context.dart';
import 'package:flutter_app/aboutcontext/page1.dart';
import 'package:flutter_app/aboutcontext/state_less_container.dart';

void main() {
  return runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("key demo"),
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
    StatelessContainer(key: UniqueKey()),
    StatelessContainer(key: UniqueKey())
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
