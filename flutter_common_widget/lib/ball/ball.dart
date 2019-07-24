import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

/// @author chenwei
/// create at 2019-07-24
/// description   球体菜单
class BallView extends StatefulWidget {
  final int count;

  const BallView({Key key, this.count}) : super(key: key);

  @override
  _BallViewState createState() => _BallViewState();
}

class _BallViewState extends State<BallView> {
  //List<Widget> _views = [];
  List<ItemViewData> _data = [];
  double radius = 100;
  double changeX = 0, changeY = 0;
  double initialX = 0, initialY = 0;
  bool isChanging = false;

  @override
  void initState() {
    super.initState();
    Future(() {
      radius = MediaQuery.of(context).size.width / 2 - 40;
      print("radius------> $radius");
      init();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _views = [];
    for (int i = 0; i < _data.length; i++) {
      _views.add(ItemView(
        data: _data[i],
      ));
    }
    return GestureDetector(
      onLongPressStart: (LongPressStartDetails details) {
        print(
            "onLongPressStart: ${details.globalPosition.dx}---${details.globalPosition.dy}");
      },
      onLongPressUp: () {},
      onLongPressEnd: (LongPressEndDetails details) {
        print(
            "onLongPressEnd: ${details.globalPosition.dx}---${details.globalPosition.dy}");
      },
      onPanDown: (DragDownDetails details) {
        print(
            "onPanDown: ${details.globalPosition.dx}---${details.globalPosition.dy}");
      },
      onPanCancel: () {
        print("onPanCancel:  ");
      },
      onPanStart: (DragStartDetails details) {
        print(
            "onPanStart: ${details.globalPosition.dx}---${details.globalPosition.dy}");
        initialX = details.globalPosition.dx;
        initialY = details.globalPosition.dy;

        /// 开始change
        isChanging = true;
        update();
      },
      onPanEnd: (DragEndDetails details) {
        print("onPanEnd:  ");
        initialX = 0;
        initialY = 0;
      },
      onPanUpdate: (DragUpdateDetails details) {
        print(
            "onPanUpdate: ${details.globalPosition.dx}---${details.globalPosition.dy}");

        changeX = details.globalPosition.dx - initialX;
        changeY = details.globalPosition.dy - initialY;

        changeX = changeX / 10;
        changeY = -changeY / 10;

        changeX = (changeX * pi / 180);
        changeY = (changeY * pi / 180);

        initialX = details.globalPosition.dx;
        initialY = details.globalPosition.dy;
      },
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: _views,
        ),
      ),
    );
  }

  void update() {
    updateViewState();
    if (isChanging) {
      Timer(Duration(milliseconds: 20), () {
        update();
      });
    }
  }

  void init() {
    List<double> phi = []; // 与Z轴夹角
    List<double> theta = []; // 与X轴夹角
    int count = widget.count; //_data.length;
    for (int i = 0; i < count; i++) {
      phi.add(acos(-1 + (2 * i + 1.0) / count));
      theta.add(sqrt(count * pi) * phi[i]);

      ItemViewData itemData = ItemViewData();
      itemData.x3 = radius * cos(theta[i]) * sin(phi[i]);
      itemData.y3 = radius * sin(theta[i]) * sin(phi[i]);
      itemData.z3 = radius * cos(phi[i]);
      itemData.width = 50;
      itemData.height = 30;
      itemData.opacity = 0;
      itemData.value = "item-${i + 1}";

      _data.add(itemData);
    }

    updateViewState();
  }

  void updateViewState() {
    double a1 = changeY;
    double b1 = changeX;
    if (isChanging) {
//      a1 *= 0.99;
//      b1 *= 0.99;
      if (a1.abs() < 0.001 && b1.abs() < 0.001) {
        isChanging = false;
        return;
      }
    }
    print("===========  changeX: ${changeX}, changeY: ${changeY}");
    int count = _data.length;
    for (int i = 0; i < count; i++) {
      ItemViewData itemData = _data[i];

      double rx1 = itemData.x3;
      double ry1 = itemData.y3 * cos(a1) + itemData.z3 * (-sin(a1));
      double rz1 = itemData.y3 * sin(a1) + itemData.z3 * cos(a1);

      double rx2 = rx1 * cos(b1) + rz1 * sin(b1);
      double ry2 = ry1;
      double rz2 = rx1 * (-sin(b1)) + rz1 * cos(b1);

      itemData.radius = radius;

      itemData.x3 = rx2;
      itemData.y3 = ry2;
      itemData.z3 = rz2;

      double per = (rz2 + radius) /
          (2 *
              radius); //1 - (radius - rz2.abs()) / radius; //(radius * 2) / (radius * 2 + rz2) / 2;

      itemData.opacity = per < 0.5 ? 0.5 : per;
      //itemData.width = itemData.width * per;
      //itemData.height = itemData.height * per;

      itemData.x2 = itemData.x3 + radius + 40 - itemData.width / 2;
      itemData.y2 = itemData.y3 + radius + 40 - itemData.height / 2;
      _data[i] = itemData;
    }
    setState(() {});
  }
}

class ItemViewData {
  /// 三维坐标
  double x3;
  double y3;
  double z3;

  ///  二维坐标
  double x2;
  double y2;

  /// ItemView的宽高
  double width;
  double height;

  /// 透明度
  double opacity;

  double radius;

  /// itemview要显示的内容
  String value;

  ItemViewData(
      {this.x3,
      this.y3,
      this.z3,
      this.x2,
      this.y2,
      this.width,
      this.height,
      this.opacity,
      this.value});
}

class ItemView extends StatelessWidget {
  final ItemViewData data;

  const ItemView({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("------------------------");
    print(
        "x2: ${data?.x2}, y2: ${data?.y2}, opacity: ${data.opacity}, rz2: ${data.z3}, radius: ${data.radius}");
    print("------------------------");

    return data == null
        ? Container()
        : Positioned(
            left: data.x2 < 0 ? 0 : data.x2,
            top: data.y2 < 0 ? 0 : data.y2,
            child: GestureDetector(
              child: Opacity(
                opacity: data.opacity,
                child: Container(
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      data.value ?? "default",
                      style: TextStyle(fontSize: 8.0),
                    ),
                  ),
                  width: data.width * data.opacity,
                  height: data.height * data.opacity,
                ),
              ),
//              onTap: () {
//                Scaffold.of(context).showSnackBar(SnackBar(
//                  content: Text("你点我了"),
//                  duration: Duration(milliseconds: 600),
//                ));
//              },
            ));
  }
}
