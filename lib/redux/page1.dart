import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'count_redux.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("page1")),
      body: Column(
        children: <Widget>[
          StoreConnector<CountState, int>(
            converter: (store) => store.state.count,
            builder: (context, count) {
              return Text(count.toString());
            },
          ),
        ],
      ),
    );
  }
}
