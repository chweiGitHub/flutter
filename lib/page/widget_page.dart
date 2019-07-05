import 'package:flutter/material.dart';
import 'package:flutter_app/utils/widget_utils.dart';
import 'package:flutter_app/widget/custom_notification.dart';
import 'package:flutter_app/widget/item.dart';
import 'package:flutter_app/widget/position_widget.dart';
import 'package:common_utils/common_utils.dart';

class WidgetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WidgetPageState();
  }
}

class _WidgetPageState extends State<WidgetPage> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  List<Widget> _widgetList = [];
  List<GlobalKey> _keyList =[];
  List _list = [
    {"value": "TextField", "route": "/text_field_note"},
    {"value": "Container", "route": "/container_note"},
    {"value": "InkWell", "route": "/ink_well"},
    {"value": "ListView", "route": "/list_view_note"},
    {"value": "TextField", "route": "/text_field_note"},
    {"value": "Container", "route": "/container_note"},
    {"value": "InkWell", "route": "/ink_well"},
    {"value": "ListView", "route": "/list_view_note"},
    {"value": "TextField", "route": "/text_field_note"},
    {"value": "Container", "route": "/container_note"},
    {"value": "InkWell", "route": "/ink_well"},
    {"value": "ListView", "route": "/list_view_note"},
    {"value": "TextField", "route": "/text_field_note"},
    {"value": "Container", "route": "/container_note"},
    {"value": "InkWell", "route": "/ink_well"},
    {"value": "ListView", "route": "/list_view_note"},
    {"value": "TextField", "route": "/text_field_note"},
    {"value": "Container", "route": "/container_note"},
    {"value": "InkWell", "route": "/ink_well"},
    {"value": "ListView", "route": "/list_view_note"},
    
  ];

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
//    curve = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    animation.addListener(() { print("animation change ....${animation.value}");
      setState(() {});
    });

    for (int i =0; i < _list.length; i++) {
      var value = _list[i];
      GlobalKey key = GlobalKey();
      _keyList.add(key);
      _widgetList.add( ItemView(
          onPress: (Offset offset, Size size) {

//            Offset offset = WidgetUtil.getWidgetLocalToGlobal(context);
//            RenderBox box =  _keyList[6].currentContext.findRenderObject();
//            Offset offset = box.localToGlobal(Offset.zero);
//            print("-======-----------------------------------------------------=======> ${offset.dx}---${offset.dy}");


           // Navigator.of(context).pushNamed(value['route']);
            print("widget_page 接收到发送的offset");
          CustomNotification(offset, size).dispatch(context);

          },
          value: " ${i+1}----${value['value']}",
        ),
      );
    }
//
//    _widgetList.add(PositionContainer(
//      child: Padding(
//        padding: EdgeInsets.all(20.0),
//        child: Text("aaaaaa"),
//      ),
//    ));
//
//    _widgetList.add(PositionContainer(
//      child: Padding(
//        padding: EdgeInsets.all(20.0),
//        child: Text("bbbbb"),
//      ),
//    ));
//    _widgetList.add(PositionContainer(
//      onTap: (){ print("adfaaaaaaaaaaaaaaaaaaaaaaaa ${animation.value}");
//        controller.forward();
//      },
//      child:
//      Stack(
//        children: <Widget>[
//          Padding(
//            padding: EdgeInsets.all(20.0),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Text("ccccc"),
//              ],
//            ),
//          ),
//          Positioned(
//              top: 0 + 314 * animation.value,
//              right: 16 ,//+ 84 * animation.value,
//              child: Container(child: Icon(Icons.ac_unit, size: 10.0)))
//        ],
//      )
//
//    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("WidgetPage--build...");


    return Scaffold(
      appBar: AppBar(
        title: Text("widgets"),
      ),
      body:   ListView(
        children: ListTile.divideTiles(
            context: context, tiles: _widgetList, color: Colors.yellow)
            .toList(),
      ),
    );
  }
}
