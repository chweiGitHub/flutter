import 'dart:async';

import 'package:flutter/material.dart';

class ListViewNote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListViewNoteState();
  }
}

class _ListViewNoteState extends State<ListViewNote> {
  List<Widget> _items = [];

  @override
  void initState() {
    super.initState();
    loadNewData();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ListView"),),
      body:  RefreshIndicator(child: ListView(
        children: _items,
      ), onRefresh: (){
      print("onrefresh.....");
       return  refreshData ();
      })
    );
  }

  void loadNewData() {
//     Timer timer  =  Timer(Duration(seconds: 3), (){
//       print("-=-=-=-=");
//       var list = [];
//       for (int i = 0; i < 10; i++) {
//         list.add(
//           Padding(
//             padding: EdgeInsets.all(10.0),
//             child: Card(
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   left: 12.0,
//                   right: 12.0,
//                   top: 22.0,
//                   bottom: 22.0,
//                 ),
//                 child: Text("item - ${i + 1}"),
//               ),
//             ),
//           ),
//         );
//       }
//       _items.addAll(()=> list);
//      });
//     timer.cancel();
  }
  Future<bool> refreshData () async{
    _items.clear();
    loadNewData();
    return true;
  }
}
