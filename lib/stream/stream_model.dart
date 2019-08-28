import 'dart:async';

import 'dart:io';
import 'dart:convert';

import 'bean/book_response_entity.dart';

class StreamModel {
  StreamController _controller;

  StreamSink<List<BookResponseData>> _sink;

  Stream<List<BookResponseData>> stream;

  StreamModel() {
    // 构造方法中初始化流相关的对象
    _controller = StreamController<List<BookResponseData>>.broadcast();
    _sink = _controller.sink;
    stream = _controller.stream;
  }
  /// 获取书本列表
  getBookList() async {
    var httpClient = new HttpClient();
    var uri = new Uri.https('www.apiopen.top', '/novelApi');
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    // 将获取到的字符串转换成定义好的Book实体类
    BookResponseEntity entity =
        BookResponseEntity.fromJson(json.decode(responseBody));
    // 接口中拿到数据之后，通过sink.add 添加一条流即可， 这样在StreamBuild中就会有回调。
    _sink.add(entity.data);
  }
  /// 资源
  dispose() {
    _sink.close();
    _controller.close();
  }
}

//stream.transform(StreamTransformer<List<BookResponseData>,
//    List<BookResponseData>>.fromHandlers(handleData: (data, sink) {
//print("测试。。。。");
//List<BookResponseData> list = [];
//data.forEach((BookResponseData data) {
//print("bookname:" +
//data.bookname +
//"---" +
//data.bookname.contains("医").toString());
//if (!data.bookname.contains("医")) return list.add(data);
//});
//_sink.add(list);
//}));
