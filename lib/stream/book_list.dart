import 'package:flutter/material.dart';

class NewsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsListState();
  }
}

//https://api.apiopen.top/getSingleJoke?sid=28654780
//https://www.apiopen.top/novelApi

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("stream demo"),),
      body: Container(
        child: StreamBuilder(
            initialData: null,
            stream: null,
            builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              return Container();
            }),
      ),
    );
  }
}
