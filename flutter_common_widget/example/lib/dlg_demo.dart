import 'package:flutter/material.dart';
import 'package:flutter_common_widget/utils/index.dart';

class DlgList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> views = <Widget>[
      ListTile(
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.green,
        ),
        title: Text("确认弹框"),
        onTap: () {
          showConfirmDlg(context, "Are you sure ？", confirmFun: () {});
        },
      ),
      ListTile(
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.green,
        ),
        title: Text("自定义显示内容的确认弹框"),
        onTap: () {
          showConfirmDlg(
              context,
              Column(
                children: <Widget>[
                  Text(
                    "You have a new message.",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Text(
                    "check ?",
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "yes, of course...",
                    style: TextStyle(color: Colors.red),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.timer,
                        color: Colors.blue,
                      ),
                      Text("here you are..."),
                    ],
                  ),
                ],
              ),
              confirmFun: () {});
        },
      ),
      ListTile(
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.green,
        ),
        title: Text("自定义显示内容/按钮的确认弹框"),
        onTap: () {
          showConfirmDlg(
            context,
            Column(
              children: <Widget>[
                Text(
                  "You have a new message.",
                  style: TextStyle(color: Colors.blue),
                ),
                Text(
                  "check ?",
                  style: TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold),
                ),
                Text(
                  "yes, of course...",
                  style: TextStyle(color: Colors.red),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      color: Colors.blue,
                    ),
                    Text("here you are..."),
                  ],
                ),
              ],
            ),
            confirmFun: () {},
            customActionWidget: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("按钮1"),
                  onPressed: () {},
                ),
                RaisedButton(
                  child: Text("按钮2"),
                  onPressed: () {},
                ),
                RaisedButton(
                  child: Text("按钮3"),
                  onPressed: () {},
                ),
              ],
            ),
          );
        },
      ),
      ListTile(
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.green,
        ),
        title: Text("提醒弹框"),
        onTap: () {
          showCenterRemindDlg(context, "你有一条新消息");
        },
      ),
      ListTile(
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.green,
        ),
        title: Text("底部弹框"),
        onTap: () {
          showBottomDlg(context, null);
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("弹框demo"),
      ),
      body: ListView(
        children:
            ListTile.divideTiles(tiles: views, color: Colors.green).toList(),
      ),
    );
  }
}
