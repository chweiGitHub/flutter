import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/provider/bean/book_response_entity.dart';

class Book with ChangeNotifier {
  List<BookResponseData> _bookList;

  List<BookResponseData> get bookList => _bookList ?? [];

  /// 请求接口获取图书列表
  loadBookList() async {
    var httpClient = new HttpClient();
    var uri = new Uri.https('www.apiopen.top', '/novelApi');
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    // 将获取到的字符串转换成定义好的Book实体类
    BookResponseEntity entity =
        BookResponseEntity.fromJson(json.decode(responseBody));
    _bookList = entity.data;
    // 接口返回图书列表后 发送一个通知，通知UI刷新
    notifyListeners();
  }
  @override
  void dispose() {
    super.dispose();
  }
}
