import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/share_demo/custom_notification.dart';
import 'package:flutter_app/share_demo/size_view.dart';

import 'animation_move_page.dart';

class GoodsListPage extends StatefulWidget {
  @override
  _GoodsListPageState createState() => _GoodsListPageState();
}

class _GoodsListPageState extends State<GoodsListPage> {
  List<Widget> goodsListView = []; // const final

  Offset sOffset, eOffset;
  Size sSize, eSize;
  Widget dotView;
  GlobalKey eKey;

  @override
  void initState() {
    // Function
    super.initState();

    eKey = GlobalKey();

    // 模拟网络请求返回， 2秒后获取到数据
    Timer(Duration(seconds: 2), () {
      List<GoodsInfo> response = [
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
      List<Widget> list = [];
      response.forEach((GoodsInfo data) {
        // 注意forEach的坑！！！
        // if(data.id == 1001) return;
        list.add(GoodsItemView(
          data: data,
        ));
      });

      setState(() {
        goodsListView = list;
      });

      // 以下两种方式都可以在页面渲染完成后回调
      // 1. 系统回调方法
      WidgetsBinding.instance.addPostFrameCallback((_){
        RenderBox renderBox = eKey.currentContext.findRenderObject();
        setState(() {
          eOffset = renderBox.localToGlobal(Offset.zero);
          eSize = renderBox.size;
        });
      });
      // 2. Future方式  -- 为什么用Future可以实现？？？
//      Future(() {
//        RenderBox renderBox = eKey.currentContext.findRenderObject();
//        setState(() {
//          eOffset = renderBox.localToGlobal(Offset.zero);
//          eSize = renderBox.size;
//        });
//      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (CustomNOtification data) {
        setState(() {
          sOffset = data?.data?.localToGlobal(Offset.zero);
          sSize = data?.data.size;
          dotView = Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10.0),
            ),
          );
        });
        return true;
      },
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: Text("商品列表"),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.add)),
              ],
            ),
            body: ListView(
              children: goodsListView,
            ),
            floatingActionButton: Icon(
              Icons.business_center,
              size: 80.0,
              color: Colors.red,
              key: eKey,
            ),
          ),
          AnimationMoveContainer(
            startOffset: sOffset,
            endOffset: eOffset,
            startSize: sSize,
            endSize: eSize,
            child: dotView,
          ),
        ],
      ),
    );
  }
}

class GoodsInfo {
  GoodsInfo(this.id, this.name, {this.description, this.images});

  int id;

//  int get id=> _id;
//  set (id)=> _id= id;
  String name;
  String description;

  List<String> images;
}

class GoodsItemView extends StatefulWidget {
  final GoodsInfo data;

  const GoodsItemView({Key key, this.data}) : super(key: key);

  @override
  _GoodsItemViewState createState() => _GoodsItemViewState();
}

class _GoodsItemViewState extends State<GoodsItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 100.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  widget.data?.images[0],
                  width: 50.0,
                  height: 50.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("${widget.data?.name}"),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          widget.data?.description ??
                              "发了疯垃圾的房间里发了第三方家里的房间爱斯大林发送发送到发顺丰就劳动法说发顺丰",
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizeButton(
                  press: (RenderBox renderBo) {
                    // NOtification
                    // Inheri...
                    CustomNOtification(renderBo).dispatch(context);
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 1.0,
            color: Colors.red,
          )
        ],
      ),
    );
  }

  //
  void addToShoppingcart() {}
}
