import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/inherited_demo/user_info.dart';

import 'inherited_parent.dart';

class Son2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SonState();
  }
}

class _SonState extends State<Son2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrangeAccent,
      child:  Column(
        children: <Widget>[
          Text(
              "user-id: ${InheritedParent.of(context).data == null ? "" : InheritedParent.of(context).data.id}"),
          Text(
              "user-name: ${InheritedParent.of(context).data == null ? "" : InheritedParent.of(context).data.name}"),

        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies....");
    super.didChangeDependencies();
  }
}
