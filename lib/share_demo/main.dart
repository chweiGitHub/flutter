import 'package:flutter/material.dart';

import 'goods_list_page.dart';

void main() => runApp(StartPage());


class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GoodsListPage(),
    );
  }
}

