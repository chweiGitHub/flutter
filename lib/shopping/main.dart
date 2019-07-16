import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/shopping/rich_text_demo.dart';
import 'package:flutter_app/widget/custom_notification.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dot_move_view.dart';
import 'dot_to_me_animation_container.dart';
import 'my_special_text_span_builder.dart';

void main() => runApp(StartPage());

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      home: ExtendedText(
        'fadfasfa', // 防止搜索检索的是最后一个关键词
        maxLines: 2,
//                        overflow: ExtendedTextOverflow.ellipsis,
        specialTextSpanBuilder:
        MySpecialTextSpanBuilder(),
        style: TextStyle(
            color: Color(0xff777777),
            fontWeight: FontWeight.w600,
            fontSize: 17),
      )// MainPage(),
//      routes: {
//        "/": (_) => new WebviewScaffold(
//          url: "http://qa.paat.org/app/appdetails?id=6&userId=2",
//          appBar: new AppBar(
//            title: new Text("Widget webview"),
//          ),
//        ),
//      },
    );

//    MaterialApp(
//      routes: {
//        "/": (_) => new WebviewScaffold(
//          url: "https://qa.paat.org/app/appdetails?id=6&userId=2",
//          appBar: new AppBar(
//            title: new Text("Widget webview"),
//          ),
//        ),
//      },
//    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  List<GoodsInfo> goodsList = [
    GoodsInfo(1001, "锤子手机"),
    GoodsInfo(1002, "小米手机"),
    GoodsInfo(1003, "三星手机"),
    GoodsInfo(1004, "华为手机"),
  ];

  GlobalKey _shoppingCartKey = GlobalKey();

  Offset _endOffset, _startOffset;
  Size _endSize, _startSize;

  Widget _dotViews;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox = _shoppingCartKey.currentContext.findRenderObject();
      setState(() {
        _endOffset = renderBox.localToGlobal(Offset.zero);
        _endSize = renderBox.size;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> goodsListWidget = [];
    goodsListWidget.add(TextDemo());
    goodsList?.forEach((GoodsInfo goodsInfo) {
      if (goodsInfo.id == 1001) return;

      goodsListWidget.add(
        GoodsItemView(
          goodsInfo: goodsInfo,
        ),
      );
    });

//    String url =  "http://qa.paat.org/app/appdetails?id=6&userId=2";
//    String url = "www.baidu.com";
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("webview demo21"),
//      ),
//      body: Stack(
//        children: <Widget>[
//
//          WebView(
//            initialUrl: "http://qa.paat.org/app/appdetails?id=6&userId=2",
//            javascriptMode: JavascriptMode.unrestricted,
//            debuggingEnabled: true,
//          ),
//
//          TextField(
//            decoration:
//            InputDecoration(hintText: "请输入。。。。。1", fillColor: Colors.red),
//          ),
//        ],
//      ),
//    );

//    body:WebviewScaffold(url:url,
//    withJavascript: true,
//    ),
//    );

    return NotificationListener(
      onNotification: (CustomNotification notification) {
        setState(() {
          _startOffset = notification.startOffset;
          _startSize = notification.size;
          _dotViews = Container(
            width: 20.0,
            height: 20.0,
            color: Colors.lightBlue,
          );
        });
        return true;
      },
      child: Scaffold(
//        appBar: AppBar(
//          title: Text("商品列表"),
//        ),
        body: Stack(
          children: <Widget>[
            Scaffold(
              body: ListView(
                children: goodsListWidget,
              ),
            ),
            DotMoveView(
              startOffset: _startOffset,
              endOffset: _endOffset,
              startSize: _startSize,
              endSize: _endSize,
              child: _dotViews,
            ),
//            DotToMeAnimationContainer(
//              startOffset: _startOffset,
//              endOffset:  _endOffset,
//              startSize: _startSize,
//              endSize: _endSize,
//              children: _dotViews,
//            ),
          ],
        ),
        floatingActionButton: Icon(
          Icons.business_center,
          key: _shoppingCartKey,
          size: 36.0,
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}

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

class GoodsItemView extends StatelessWidget {
  final GoodsInfo goodsInfo;

  const GoodsItemView({Key key, this.goodsInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageView;
    if (goodsInfo != null &&
        goodsInfo.images != null &&
        goodsInfo.images.length > 0) {
      imageView = Image.asset(
        goodsInfo.images[0],
        width: 50.0,
        height: 50.0,
      );
    } else {
      imageView = Icon(
        Icons.error,
        color: Colors.red,
      );
    }

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              imageView,
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 12.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${goodsInfo.name}",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizeButton(
                  onPress: (Offset offset, Size size) {
//                    addToShoppingCart(context);
//                    print("add to ...  ");
                    CustomNotification(offset, size).dispatch(context);
                  },
                ),
                flex: 0,
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[200],
          height: 1.0,
        ),
      ],
    );
  }

  void addToShoppingCart(BuildContext context) {
    RenderBox renderBox = context.findRenderObject();
    Offset startOffset = renderBox.localToGlobal(Offset.zero);
    Size startSize = renderBox.size;

    CustomNotification(startOffset, startSize).dispatch(context);
  }
}

class SizeButton extends StatelessWidget {
  final Function onPress;

  const SizeButton({
    Key key,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.red,
      icon: Icon(Icons.add),
      onPressed: () {
        RenderBox renderBox = context.findRenderObject();
        Offset startOffset = renderBox.localToGlobal(Offset.zero);
        Size startSize = renderBox.size;
        if (onPress != null) onPress(startOffset, startSize);
      },
    );
  }
}
