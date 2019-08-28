import 'dart:async';

import 'package:flutter/material.dart';

import 'book_list.dart';

void main() {
//  testStream();
//  testSingleStream();
//  testBroadcaseStream ();
  test();
  return runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("stream...."),
        ),
        body: BookList(),
      ),
    );
  }
}

/// 说明：
/// 单订阅流： 在有监听的时候才发送数据。 在设置监听前调用sink.add 的数据会累积，直到设置监听为止，设置监听前面的数据会一次发送过来。
///           pause期间 add的数据会在resume后被监听到。
/// 广播流： 设置监听前的数据丢失，只有设置监听后调用sink.add的数据才能被监听到。
///           pause期间 add的数据会在resume后被监听到。
///
///
///

void test() {
  // 从Future中创建一个新的单订阅流
  Stream stream = Stream.fromFuture(Future(() => 1));
  // 从集合中创建一个新的单订阅流
  Stream stream1 = Stream.fromIterable([11, 22, 33]);
  // 创建一个每隔自定义时间发送一个数据的流
  Stream stream2 = Stream.periodic(Duration(seconds: 2), (a) {
    print("a------>$a");
    if (a < 3)
      return a;
    else
      return a * 10;
  });
  stream2 = stream2.take(5);
  stream2 = stream2.takeWhile((data) {
    return data < 10; // 设置一个上限为10
  });
  Stream stream3 = Stream.fromFutures([
    Future(() => 111),
    Future(() => 111),
  ]);

  stream.listen((data) {
    print("data-->$data");
  });
  stream1.listen((data) {
    print("data1-->$data");
  });
  var sub = stream2.listen((data) {
    print("data2-->$data");
  });
//  sub.cancel();

  stream3.listen((data) {
    print("data3-->$data");
  });
}

// 患得患失
void testSingleStream() {
  // 1. StreamControl
  StreamController controller = StreamController<String>(sync: true);
  // 2. StreamSink
  StreamSink sink = controller.sink;
  // 3. Stream
  Stream stream = controller.stream;
  stream.transform(StreamTransformer<String, String>.fromHandlers(
      handleData: (String data, EventSink<String> sink) {
    // 在这里设置transform 是没有用的，不会走这里； 除非在stream.transform返回的stream上加listen监听。
    if (!data.contains("数据2")) {
      sink.add(data);
    }
  }));
  sink.add("3秒后才设置监听。");
  // 4. subscribe
  Timer(Duration(seconds: 3), () {
    StreamSubscription subscription = controller.stream.transform(
        StreamTransformer<String, String>.fromHandlers(
            handleData: (String data, EventSink<String> sink) {
      print("transform");
      if (!data.contains("数据3")) {
        sink.add(data);
      }
    })).listen((event) {
      print("接收到新的消息： " + event);
    });

    sink.add("我是一条新的数据");

    Timer(Duration(milliseconds: 100), () {
      sink.add("pause...");
      subscription.pause(); // 暂停
      sink.add("我是一条新的数据pause");
    });

    Timer(Duration(seconds: 5), () {
      subscription.resume();

      sink.add("我是一条新的数据2");
    });
  });
}

void testBroadcaseStream() {
  // 1. StreamControl
  StreamController controller = StreamController.broadcast();
  // 2. sink
  StreamSink sink = controller.sink;
  // 3. Stream
  Stream stream = controller.stream;
  sink.add("3秒后才设置监听。");
  print("broadcase 测试。。。");
  // 4. subscribe
  Timer(Duration(seconds: 0), () {
    StreamSubscription subscription = controller.stream.listen((event) {
      print("接收到新的消息： " + event);
    });

    sink.add("我是一条新的数据");
    sink.add("我是另一条新的数据");

    Timer(Duration(milliseconds: 100), () {
      subscription.pause();
      sink.add("我是一条新的数据pause");
      sink.add("我是另一条新的数据pause");
    });

    Timer(Duration(seconds: 5), () {
      subscription.resume();

      sink.add("我是一条新的数据2");
      sink.add("我是另一条新的数据2");

      sink.add("我是一条新的数据3");
      sink.add("我是另一条新的数据3");
    });
  });
//  StreamSubscription subscription  =  controller.stream.listen((event){
//    print("接收到新的消息： "+ event) ;
//  });
//  StreamSubscription subscription2  =  controller.stream.listen((event){
//    print("接收到新的消息222： "+ event) ;
//  });
}

void testStream() {
  // 单订阅模式
  StreamController streamController = StreamController();
  streamController.sink.add("111");
  streamController.sink.add("111");
  streamController.sink.add("111");
  streamController.sink.add("111我尽快让他填进去");
  streamController.sink.add("111");
  streamController.stream.listen((data) {
    print("data===> $data");
  });

  streamController.sink.add("222");
  streamController.sink.add("333");
}
