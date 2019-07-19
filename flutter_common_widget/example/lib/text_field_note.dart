import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common_widget/textfield/text_field.dart';

/// @author chenwei
/// create at 2019-07-18
/// description textfield demo
class TextFieldNote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TextFieldNoteState();
  }
}

class _TextFieldNoteState extends State<TextFieldNote> {
  TextEditingController _controller;
  List<Widget> _widgetList = [];

  String value = "";

  @override
  void initState() {
    super.initState();
    print("---------------_TextFieldNoteState");
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = value;
    _controller.selection =
        TextSelection.fromPosition(TextPosition(offset: value.length));

    _widgetList = <Widget>[
      TextField(),
      TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: "请输入姓名",
          prefix: Icon(
            Icons.search,
          ), // prefix 左侧的Widget  只在有焦点的时候显示
          suffix: GestureDetector(
            child: Icon(
              Icons.close,
            ),
            onTap: () {
              setState(() {
                value = "";
              });
            },
          ), // suffix 右侧的Widget 只在有焦点的时候显示
        ),
      ),
      TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: "请输入姓名",
          hintStyle: TextStyle(
            color: Colors.purple[300],
            fontSize: 16.0,
          ),
          prefixIcon: Icon(
            Icons.search,
          ), // prefixIcon 左侧显示的Widget ,一直显示
          suffixIcon: GestureDetector(
            child: Icon(
              Icons.close,
            ),
            onTap: () {
              setState(() {
                value = "";
              });
            },
          ), // suffixIcon 右侧显示的Widget,一直显示
        ),
      ),
      Container(
        padding: EdgeInsets.only(
          left: 12.0,
          right: 12.0,
        ),
        margin: EdgeInsets.only(
          top: 12.0,
          bottom: 12.0,
        ),
        child: TextField(
          controller: _controller,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp("[0-9a-zA-Z]"))
          ], //允许的输入格式
          decoration: InputDecoration(
            labelText: "请输入姓名1",
            helperText: "help",
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.yellow,
              width: 1.0,
            )),
            hintText: "请输入姓名",
            hintStyle: TextStyle(
              color: Colors.grey[300],
              fontSize: 16.0,
            ),
            prefixIcon: Icon(
              Icons.search,
            ),
            // prefixIcon 左侧显示的Widget ,一直显示
            suffixIcon: GestureDetector(
              child: Icon(
                Icons.close,
              ),
              onTap: () {
                setState(() {
                  value = "";
                });
              },
            ), // suffixIcon 右侧显示的Widget,一直显示
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(
          left: 12.0,
          right: 12.0,
        ),
        margin: EdgeInsets.only(
          top: 12.0,
          bottom: 12.0,
        ),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.yellow,
              width: 1.0,
            )),
            hintText: "isDense: true",
            hintStyle: TextStyle(
              color: Colors.grey[300],
              fontSize: 16.0,
            ),
            prefixIcon: Icon(
              Icons.search,
            ),
            // prefixIcon 左侧显示的Widget ,一直显示
            suffixIcon: GestureDetector(
              child: Icon(
                Icons.close,
              ),
              onTap: () {
                setState(() {
                  value = "";
                });
              },
            ), // suffixIcon 右侧显示的Widget,一直显示
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(
          left: 12.0,
          right: 12.0,
        ),
        margin: EdgeInsets.only(
          top: 12.0,
          bottom: 12.0,
        ),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 30.0, bottom: 50.0),
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.yellow,
              width: 1.0,
            )),
            hintText: "contentPadding=50.0",
            hintStyle: TextStyle(
              color: Colors.grey[300],
              fontSize: 16.0,
            ),
            prefixIcon: Icon(
              Icons.search,
            ),
            // prefixIcon 左侧显示的Widget ,一直显示
            suffixIcon: GestureDetector(
              child: Icon(
                Icons.close,
              ),
              onTap: () {
                setState(() {
                  value = "";
                });
              },
            ), // suffixIcon 右侧显示的Widget,一直显示
          ),
        ),
      ),
      // 自定义的TextField
      SearchInputView(
        hint: "请输入你想输入的内容",
        valueChange: (v) {
          print("输入的内容为： $v");
        },
        rightIconPress: () {
          print("点击了右边的icon");
        },
      ),

      Container (
        margin: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: DemoItem(),
            ),
            Expanded(
              child: DemoItem(),
            ),
            Expanded(
              child: DemoItem(),
            ),
          ],
        ),
      ),  
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("TextField"),
      ),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: _widgetList,
      ),
    );
  }
}

class DemoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Icon(
                Icons.ac_unit,
                size: 50.0,
              ),
              Text("￥888.88"),
            ],
          ),
          Container(
            padding: EdgeInsets.only(
              top: 6.0,
              bottom: 6.0,
            ),
            child: Text("哈哈哈哈"),
          ),
        ],
      ),
    );
  }
}
