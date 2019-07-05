import 'package:flutter/material.dart';

void main() {
  return runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: AnimationPages(),
    );
  }
}

class AnimationPages extends StatefulWidget {
  var isShow = false;

  @override
  State<StatefulWidget> createState() => AnimationPagesState();
}

class AnimationPagesState extends State<AnimationPages>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  GlobalKey _shopkey = GlobalKey();
  GlobalKey _startkey = GlobalKey();
  double differentY = 0;
  double differentX = 0;
  Offset endOffset;
  List<String> list = List();

  AppBar appbar = AppBar(
    title: Text("这是动画测试页面"),
  );

  bool show = true;
  Offset startOffset;
  Size startSize;
  int clickPosition = 0;

  bool isShow = true;
  Stack parent;
  int count = 0;

  @override
  Widget build(BuildContext context) => _getRootWidget();

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback(_getShopBox());
    super.initState();

    list.add("images/test.jpg");
    list.add("images/test.jpg");
    list.add("images/test.jpg");

    _controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    var curve = CurvedAnimation(parent: _controller, curve: Interval(0.0, 1.0));
    _animation = Tween(begin: 1.0, end: 0.0).animate(curve);
    _animation.addListener(() {
      setState(() {});
    });
  }

  Widget _getRootWidget() {
    return Scaffold(
      appBar: appbar,
      body: _getStackParent(),
    );
  }

  Widget _getStackParent() {
    parent = Stack(
      children: <Widget>[
        Center(
          child: Column(
            children: <Widget>[
//              Center(
//                child: Text("这是个title"),
//              ),
              Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int position) {
                    return ItemChildWidget(
                      position: position,
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.ac_unit,
                          color: Colors.blue,
                          size: 50.0,
                        ),
                      ),
                      callBack: (box) {
                        show = false;
                        startOffset = box.localToGlobal(Offset.zero);
                        startSize = box.size;
                        clickPosition = position;
                        print(parent.children.length);
                        _shoppingClick(box);
                        count = 1;
                        setState(() {});
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
       AnimationItemMove(
           children: _getMoveWidgets(),
           show: show,
           offset: startOffset,
           size: startSize,
           defferentX: differentX,
           defferentY: differentY,
         ),
        Positioned(
          right: 30,
          bottom: 30,
          width: 50,
          height: 50,
          child: GestureDetector(
            child: Container(
              key: _shopkey,
              width: 50,
              height: 50,
              child: Icon(
                Icons.mail,
                color: Colors.blue,
                size: 50.0,
              ),
            ),
            onTap: () {
              _controller.reverse();
            },
          ),
        ),
      ],
    );
    return parent;
  }

  List<Widget> _getMoveWidgets() {
    var datas = List<Widget>();
    for (var i = 0; i < count; i++) {
      datas.add(Container(
        height: 50,
        width: 50,
        child: Icon(
          Icons.attach_money,
          color: Colors.blue,
          size: 60.0,
        ),
      ));
    }
    print(count);
    return datas;
  }

  _shoppingClick(RenderBox box) {
    RenderBox endBox = _shopkey.currentContext.findRenderObject();
    endOffset = endBox.localToGlobal(Offset.zero);
    Offset startOffset = box.localToGlobal(Offset.zero);
    if (endOffset != null) {
      differentY = endOffset.dy - startOffset.dy;
      differentX = endOffset.dx - startOffset.dx;
    }
  }
}

class ItemChildWidget<T> extends StatelessWidget {
  final int position;
  final Widget child;
  final ItemClickCallBack callBack;

  ItemChildWidget({this.position, this.child, this.callBack});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _getItemChildWidget(context);
  }

  Widget _getItemChildWidget(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 90.0),
        color: Colors.orange,
        child: child,
      ),
      onTap: () {
        RenderBox box = context.findRenderObject();
        Offset offset  = box.localToGlobal(Offset.zero);
        print("点击的： ${offset.dx} -- ${offset.dy}");
        callBack(box);
      },
    );
  }
}

class AnimationItemMove extends StatefulWidget {
  final List<Widget> children;
  final bool show;
  final Offset offset;
  final Size size;
  final double defferentX;
  final double defferentY;

  AnimationItemMove(
      {this.children,
      @required this.show,
      @required this.offset,
      @required this.size,
      @required this.defferentX,
      @required this.defferentY});

  @override
  State<StatefulWidget> createState() => AnimationItemMoveState();
}

class AnimationItemMoveState extends State<AnimationItemMove>
    with SingleTickerProviderStateMixin {
  // Animation<double> _animation;
  // AnimationController _controller;
  var newChildren = List<Widget>();

  @override
  Widget build(BuildContext context) => _getRootWidget(context);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  void didUpdateWidget(AnimationItemMove oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
    // _controller.reset();
    // _controller.forward();
  }

  Widget _getRootWidget(BuildContext context) {
    return Offstage(
      offstage: widget.show,
      child: Stack(
        children: _getChild(),
      ),
    );
  }

  List<Widget> _getChild() {
    for (var item in widget.children) {
      var itemChild = AnimaPositioned(
        child: item,
        show: widget.show,
        offset: widget.offset,
        size: widget.size,
        defferentX: widget.defferentX,
        defferentY: widget.defferentY,
        yOffset: _getYdifferet(),
        callBack: (parent) {
          // newChildren.remove(parent);
          print(" remove widget.children.length: ${widget.children.length} ==== ${newChildren.length}");

          newChildren.removeAt(0);  // ???????
          print("after widget.children.length: ${widget.children.length} ==== ${newChildren.length}");

          setState(() {});
        },
      );
      newChildren.add(itemChild);
    }
    print("newChildern.... ${newChildren.length}");
    return newChildren;
  }

  double _getYdifferet() {
    RenderBox box = context.findRenderObject();
    if (box != null) {
      Offset offset = box.localToGlobal(Offset.zero);
      return offset.dy;
    } else {
      return 0;
    }
  }

// Widget _getStackView() {
//   var parent = Stack();
//   parent.children.add();
// }
}

class AnimaPositioned extends StatefulWidget {
  final Widget child;
  final bool show;
  final Offset offset;
  final Size size;
  final double defferentX;
  final double defferentY;
  final double yOffset;
  final AnimationFinshCallBack callBack;

  AnimaPositioned({
    this.child,
    this.defferentX,
    this.defferentY,
    this.offset,
    this.show,
    this.size,
    this.yOffset,
    this.callBack,
  });

  @override
  State<StatefulWidget> createState() => AnimaPositionedState();
}

class AnimaPositionedState extends State<AnimaPositioned>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  Widget build(BuildContext context) => _getRootWidget();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween(begin: 1.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          widget.callBack(widget);
        }
      });
    var widgetsbinding = WidgetsBinding.instance;
    widgetsbinding.addPostFrameCallback((callback) {
      _controller.forward();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(AnimaPositioned oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Widget _getRootWidget() {
    print("widget-offset: ${widget.offset.dx}--${widget.offset.dy}");
//    return Transform.translate(offset: Offset(widget.offset.dx /*+ widget.defferentX* (1 - _animation.value)*/, widget.offset.dx /*+ widget.defferentY* (1 - _animation.value)*/),
//  return  Container(
//    color: Colors.red,
//          margin: EdgeInsets.only(
//            left: widget.offset.dx,
//            top:widget.offset.dy-84,
//          ),
//          child: widget.child,
//        );
//    return Transform.translate(offset: Offset(0, 0),
//          child: Opacity(
//        opacity: _animation.value,
//        child: Container(
//          margin: EdgeInsets.only(
//            left: widget.offset.dx,
//            top:widget.offset.dy,
//          ),
//          child: widget.child,
//        ),
//      ),);


//    var top = _getOffset().dy -
//        widget.yOffset +
//        widget.defferentY * (1 - _animation.value);
//    var left  =  _getOffset().dx + widget.defferentX * (1 - _animation.value);
//print(" --------------------------------------------------- top:${top}, left:${left}");
var top  = _getOffset().dy - widget.yOffset ;
var left =  _getOffset().dx ;
print(" ---------------------------2------------------------ top:${top}, left:${left}");

    return Positioned(
      top: top,
      // top: _getOffset().dy + widget.defferentY * (1 - _animation.value),
      left: left,
      height: _getSize().height ,// * _animation.value,
      width: _getSize().width ,//* _animation.value,
      child: Container(
        color: Colors.red,
        child: Opacity(
          opacity:1.0, // _animation.value,
          child: widget.child,
        ),
      ),
    );
  }

  Offset _getOffset() {
    if (widget.offset != null) {
      // print(widget.offset.dy);
      return widget.offset;
    } else {
      return Offset(0, 0);
    }
  }

  Size _getSize() {
    if (widget.size != null) {
      return widget.size;
    } else {
      return Size(0, 0);
    }
  }
}

typedef ItemClickCallBack = void Function(RenderBox box);
typedef AnimationFinshCallBack = void Function(Widget parent);
