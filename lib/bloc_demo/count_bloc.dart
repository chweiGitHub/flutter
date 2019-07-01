import 'dart:async';

class CountModel {
  CountModel() {
    _count = 0;
    _streamController = StreamController.broadcast();
  }

  int _count;
  get value=> _count;

  get stream => _streamController.stream;

  increment(){
    _streamController.sink.add(++_count);
  }

  reduce(){
    _streamController.sink.add(--_count);
  }

  StreamController<int> _streamController;

  dispose() {
    _streamController.close();
  }
}
