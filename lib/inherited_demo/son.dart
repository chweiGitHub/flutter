import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/inherited_demo/son2.dart';
import 'package:flutter_app/inherited_demo/user_info.dart';

import 'inherited_parent.dart';

class Son extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SonState();
  }
}

class _SonState extends State<Son> {
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
          RaisedButton(
            onPressed: () {
              InheritedParent.of(context).change();
            },
            child: Text("change...."),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Son2()));
            },
            child: Text("跳转"),
          ),
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
