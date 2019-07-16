import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/page/home_page.dart';
import 'package:flutter_app/page/login_page.dart';
import 'package:flutter_app/shoppingv2/CustomNotification.dart';
import 'package:flutter_app/shoppingv2/animation_move_view.dart';

void main() => runApp(StartPage());

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

//    dynamic a = 123;
//    a = "test_dynamic";
//    print("a--------$a");
//    Object b = 222;
//    b ="test_object";
//    print(b);
//    var c = "aaa";
////    c = 1;
//
//    final dateFinal = DateTime.now();
//    const dateConst = DateTime.now();
//
//    final listFinal  = [1,2,3];
//    listFinal[0] = 111;
//    const listConst = [1,2,3];
//    listConst[0] = 111;


    return MaterialApp(
      home: Scaffold(
        body: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  List<GoodsInfo> dataList = [];

  Offset _startOffset, _endOffset;
  Size _startSize, _endSize;
  GlobalKey _iconKey;
  Widget _dotView;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      setState(() {
        dataList = [
          GoodsInfo(1001, "锤子手机", images: ["assets/images/chuizi.jpg"]),
          GoodsInfo(1002, "小米手机", images: ["assets/images/xiaomi.jpg"]),
          GoodsInfo(1003, "三星手机", images: ["assets/images/sanxing.jpg"]),
          GoodsInfo(1004, "华为手机", images: ["assets/images/huawei.jpg"]),
          GoodsInfo(1001, "锤子手机", images: ["assets/images/chuizi.jpg"]),
          GoodsInfo(1002, "小米手机", images: ["assets/images/xiaomi.jpg"]),
          GoodsInfo(1003, "三星手机", images: ["assets/images/sanxing.jpg"]),
          GoodsInfo(1004, "华为手机", images: ["assets/images/huawei.jpg"]),
          GoodsInfo(1001, "锤子手机", images: ["assets/images/chuizi.jpg"]),
          GoodsInfo(1002, "小米手机", images: ["assets/images/xiaomi.jpg"]),
          GoodsInfo(1003, "三星手机", images: ["assets/images/sanxing.jpg"]),
          GoodsInfo(1004, "华为手机", images: ["assets/images/huawei.jpg"]),
          GoodsInfo(1001, "锤子手机", images: ["assets/images/chuizi.jpg"]),
          GoodsInfo(1002, "小米手机", images: ["assets/images/xiaomi.jpg"]),
          GoodsInfo(1003, "三星手机", images: ["assets/images/sanxing.jpg"]),
          GoodsInfo(1004, "华为手机", images: ["assets/images/huawei.jpg"]),
        ];
      });
    });

    _iconKey = GlobalKey();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox = _iconKey.currentContext.findRenderObject();
      setState(() {
        _endSize = renderBox?.size;
        _endOffset = renderBox?.localToGlobal(Offset.zero);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> viewList = [];
    dataList.forEach((GoodsInfo itemData) {
      viewList.add(ItemView(data: itemData));
    });
    print("start....${_startOffset?.toString()}");

    return NotificationListener(
      onNotification: (CustomNotification notification) {
        setState(() {
          _startSize = notification?.renderBox?.size;
          _startOffset = notification?.renderBox?.localToGlobal(Offset.zero);
          _dotView  = Container (
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              color: Colors.red,
            ),

            width: 20.0,
            height: 20.0,
          );
        });
        return true;
      },
      child: Stack(
        children: <Widget>[
          Scaffold(
            body: ListView(
              children: viewList,
            ),
            floatingActionButton: Icon(
              Icons.business_center,
              key: _iconKey,
              color: Colors.red,
            ),
          ),
          AnimationMoveView (
            startOffset: _startOffset,
            endOffset: _endOffset,
            startSize: _startSize,
            endSize: _endSize,
            child: _dotView,
          ),
        ],
      ),
    );
  }
}

class ItemView extends StatelessWidget {
  final GoodsInfo data;
  final Function toShoppingCart;

  const ItemView({Key key, this.data, this.toShoppingCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.asset(
              data.images[0],
              width: 80.0,
              height: 80.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 5.0,
                    ),
                    child: Text(
                      data.description ??
                          "这里是详细信息这里是详细信息这里是详细信息这里是详细信息这里是详细信息这里是详细信息这里是详细信息",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizeButton(
              toShoppingCart: (RenderBox renderBox) {
                //  怎样通知到父亲
                CustomNotification(renderBox).dispatch(context);
              },
            ),
          ],
        ),
        Container(
          height: 1.0,
          color: Colors.red[200],
        ),
      ],
    );
  }
}

class SizeButton extends StatelessWidget {
  final Function toShoppingCart;

  const SizeButton({Key key, this.toShoppingCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        RenderBox renderBox = context.findRenderObject();
        toShoppingCart(renderBox);
      },
      icon: Icon(
        Icons.add,
        color: Colors.red,
      ),
    );
  }
}

void toShoppingCart() {}

class GoodsInfo {
  GoodsInfo(
    this.id,
    this.name, {
    this.price,
    this.images,
    this.description,
  });

  int id;
  String name;
  double price;
  List<String> images;
  String description;
}
