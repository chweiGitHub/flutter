
import 'package:flutter/material.dart';
import 'package:flutter_app/redux/page1.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'count_redux.dart';

void main (){
  final store = Store<CountState>(reducer, initialState: CountState.initState());
  return runApp (MyApp(store));
}


class MyApp extends StatelessWidget {

  MyApp(this.store);

  final Store<CountState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider <CountState>(
      store: store,
      child: MaterialApp(
        title: 'redux-demo',
        home: Page1 (),
      ),
    );
  }
}