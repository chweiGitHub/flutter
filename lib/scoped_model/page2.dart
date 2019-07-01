import 'package:flutter/material.dart';
import 'package:flutter_app/scoped_model/user_info_model.dart';
import 'package:scoped_model/scoped_model.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserInfoModel>(
      builder: (context, child, model) {
        return Scaffold(
            appBar: AppBar(
              title: Text("page2 "),
            ),
            body: Column(
              children: <Widget>[
                Text("id: ${model.data.id}, name:${model.data.name}"),
                RaisedButton(
                  onPressed: () {
                    if (model.data.name == "emdd") {
                      model.updateUserName("spark");
                    } else {
                      model.updateUserName("emdd");
                    }
                  },
                  child: Text("change name"),
                )
              ],
            ));
      },
    );
  }
}
