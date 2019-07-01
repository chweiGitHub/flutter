import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';

///
/// 1. 创建State
/// 2. 创建action
/// 3. 创建reducer
/// 5. 创建Store
/// 6. 将Store放入顶层

class CountState {
  CountState.init() {
    this.count = 0;
  }

  CountState(cnt) {
    this.count = cnt;
  }

  int count;
}

enum Action { increment }

CountState reducer(CountState state, action) {
  if (action == Action.increment) {
    return CountState(state.count + 1);
  }
  return state;
}

main() {
  var store = Store<CountState>(reducer, initialState: CountState.init());
  return runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  MyApp(this.store);

  final Store store;

  @override
  Widget build(BuildContext context) {
//
//    var subject = new BehaviorSubject<String>();
//    subject.listen((item) => print(item));
//
//    subject.add("Item1");
//    subject.add("Item2");
//
//    subject.listen((item) => print(item.toUpperCase()));
//
//    subject.add("Item3");



    return StoreProvider<CountState>(
      store: store,
      child:  Text(" ${store.state.count}", textDirection: TextDirection.rtl,),
    );
  }
}
