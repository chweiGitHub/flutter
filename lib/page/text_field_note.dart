import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldNote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TextFieldNoteState();
  }
}

class _TextFieldNoteState extends State<TextFieldNote> {
  TextEditingController _controller;
  List<Widget> _widgetList = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _widgetList = <Widget>[
      TextField(),
      TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: "请输入姓名",
          prefix: Icon(
            Icons.search,
          ), // prefix 左侧的Widget  只在有焦点的时候显示
          suffix: Icon(
            Icons.close,
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
          suffixIcon: Icon(
            Icons.close,
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
            suffixIcon: Icon(
              Icons.close,
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
            suffixIcon: Icon(
              Icons.close,
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
            suffixIcon: Icon(
              Icons.close,
            ), // suffixIcon 右侧显示的Widget,一直显示
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.search),
            Expanded(
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.search,
                expands: false,
                onChanged: (value) {},
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
                onSubmitted: (value) {},
                onEditingComplete: () {},
                autofocus: true,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    isDense: true,
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 13.0),
                    hintText: "请输入要搜索的内容"),
              ),
            ),
            GestureDetector(child: Icon(Icons.close), onTap: () {}),
          ],
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
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
