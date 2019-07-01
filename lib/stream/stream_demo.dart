import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  testStream();

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
      ),
    );
  }
}

void testStream() {
  StreamController streamController = StreamController();
  streamController.sink.add("111");
  streamController.stream.listen((data) {
    print("data===> $data") ;
  });

  streamController.sink.add("222");
  streamController.sink.add("333");


}
