import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bean/book_response_entity.dart';
import 'model/book_model.dart';

// 通过 ChangeNotifierProvider 将Book这个model和页面Widget建立联系， 这样在Widget中才可以通过Provider.of(context)来找到。
void main() => runApp(ChangeNotifierProvider<Book>(
      builder: (context) => Book(),
      child: MainPage(),
    ));

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      home: BookListPage(),
    );
  }
}

/// 书本列表页面
class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  @override
  void initState() {
    super.initState();
    // 由于Provider获取对应的Model需要Context，所以不能直接放到initState 中，在initState中context还没有。
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 这个是在页面绘制完成后回调， 那个时候肯定是有context 的
      Provider.of<Book>(context).loadBookList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 直接通过Provider.of 方法获取到对应的model， 通过model来获取数据或者操作数据。 这里是直接获取到 书本列表
    List<BookResponseData> list = Provider.of<Book>(context).bookList;
    return Scaffold(
      appBar: AppBar(
        title: Text("provider demo"),
      ),
      body: Container(
        child: ListView(
          children: list.map((BookResponseData data) {
            // 根据bookList这个数据生成对应的ItemView list .
            return Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlue, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${data.bookname}--${data.authorName}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text(data.bookInfo),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
