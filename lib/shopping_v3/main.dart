import 'package:flutter/material.dart';
import 'package:flutter_app/shopping_v3/shopping_list_page.dart';

 void main ()=> runApp (StartPage ());

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingListPage (),
    );
  }
}


