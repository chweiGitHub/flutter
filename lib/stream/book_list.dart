import 'package:flutter/material.dart';

import 'bean/book_response_entity.dart';
import 'stream_model.dart';

class BookList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookListState();
  }
}

//https://api.apiopen.top/getSingleJoke?sid=28654780
//https://www.apiopen.top/novelApi

class _BookListState extends State<BookList> {
  StreamModel streamModel;

  @override
  void initState() {
    super.initState();
    streamModel = StreamModel();
  }

  @override
  Widget build(BuildContext context) {
//    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("stream demo"),
      ),
      body: Container(
        child: StreamBuilder<List<BookResponseData>>(
          stream: streamModel.stream,
          initialData: [],
          builder: (context, a) {
            List<Widget> views = [];
            if (a.data != null && a.data.length > 0) {
              a.data.forEach((BookResponseData data) {
                views.add(Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        data.bookname,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(data.bookInfo),
                    ],
                  ),
                ));
              });
            }
            return ListView(
              children: views,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Text("获取数据"),
          onPressed: () {
            streamModel.getBookList();
          }),
    );
  }
  @override
  void dispose() {
    streamModel.dispose();
    super.dispose();
  }
}
