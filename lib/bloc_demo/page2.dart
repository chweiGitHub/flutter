import 'package:flutter/material.dart';

import 'count_bloc.dart';
import 'container.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CountModel data = ContainerView.of(context);

    return StreamBuilder(
        stream: data.stream,
        initialData: data.value,
        builder: (BuildContext context, AsyncSnapshot asyncshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text('page2'),
            ),
            body:


                ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    data.increment();
                  },
                  child: Text("+"),
                ),
                Text("${asyncshot.data}"),
                RaisedButton(
                  onPressed: () {
                    data.reduce();
                  },
                  child: Text("-"),
                ),
              ],
            ),



                CircleAvatar(
                  child: Image.network(
                      "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg"),
//                backgroundColor: Color(0xffff0000),
//              backgroundImage: NetworkImage(
//                  "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg"),
                  radius: 40.0,
//              foregroundColor: Color(0x55000000),
                ),
                Align(
                  child: CircleAvatar(
                    child: Image.network(
                        "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg"),
//                backgroundImage: new NetworkImage(
//                    "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg"),
                    backgroundColor: Color(0xffff0000),
                    radius: 40.0,
                  ),
                ),
                //圆行图片
                Align(
                  child: CircleAvatar(
//                child: Image.network(
//                    "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg"),
                    backgroundImage: NetworkImage(
                        "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg"),
                    backgroundColor: Color(0xffff0000),
                    radius: 40.0,
                  ),
                ),
                Align(
                  child: CircleAvatar(
//                child: Image.network(
//                    "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg"),
                    backgroundImage: NetworkImage(
                        "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg"),
                    foregroundColor: Color(0xffff0000),
                    radius: 40.0,
                  ),
                ),
                Align(
                  child: ClipOval(
                    child: SizedBox(
                      width: 80.0,
                      height: 80.0,
                      child: Image.network(
                        "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Align(
                    child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg",
                      ),
                    ),
                  ),
                )),
                //圆角图片
                Align(
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    width: 80.0,
                    height: 80.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Align(
                    child: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  width: 80.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg",
                      ),
                    ),
                  ),
                )),
              ],
            ),
          );
        });
  }
}
