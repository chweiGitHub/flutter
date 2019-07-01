import 'dart:async';

import 'package:rxdart/rxdart.dart';

void main() {
  // rxdart start ..
  final subject = PublishSubject<String>();
  subject.stream.listen((info) {
    print("我是第一个监听： $info");
  });
  subject.add("第1步");
  subject.add("第2步");
  subject.add("第3步");
  subject.add("第4步");
  subject.stream.listen((info) {
    print("我是第二个监听：$info");
  });
  subject.add("第5步");

  // stream。。。。start

  StreamController streamController = StreamController();
  streamController.sink.add("测试1");
  StreamTransformer streamTransformer =
      StreamTransformer.fromHandlers(handleData: (value, sink) {
    if (value == "测试1") {
      print("我是测试1");
    } else {
      print("我不是测试1");
    }
  });
  StreamSubscription streamSubscription =
      streamController.stream.transform(streamTransformer).listen((data) {
    print("测试1:$data");
  });
  streamController.sink.add("测试2");
  streamController.sink.add("测试3");


  Observable<int> ob = Observable(Stream.fromIterable([1, 2, 3, 4, 5]));
  ob.listen((value) {
    print("ob--> $value");
  });


testCompleter();


}


Future testCompleter () async {
  Completer completer  = Completer();
  print("start.....");
  Timer (Duration(seconds: 5), (){
    completer.complete(" is done");
  });
  var res = await completer.future;

  print("完成.....$res");
}