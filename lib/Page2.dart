import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Page2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Page2State();
  }
}

class Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<CountState, int>(
        converter: (store) => store.state.count,
        builder: (context, count) {
          return Center(
            child: InkWell(
              onTap: (){

              },
              child: Text(count.toString()),
            ),
          );
        });
  }
}
