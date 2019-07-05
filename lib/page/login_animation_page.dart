import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/page/search_page.dart';
import 'package:flutter_app/resource/ResIndex.dart';
import 'package:flutter_app/utils/DlgUtil.dart';
import 'package:flutter_app/widget/fade_page_router.dart';
import 'package:flutter_app/widget/scale_page_router.dart';

/*
 * 登录成功 动画页
 */
class LoginAnimationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginAnimationPageState();
  }
}

class _LoginAnimationPageState extends State<LoginAnimationPage>
    with TickerProviderStateMixin {
  AnimationController _hideController;
  Animation _hideAnimation;

  AnimationController _showController;
  Animation _showAnimation;

  AnimationController _scaleController;
  Animation _scaleAnimation;

  bool isUpShow = true;

  @override
  void initState() {
    super.initState();

    // 初始化动画
    _hideController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _hideAnimation = Tween(begin: 1.0, end: -1.0).animate(_hideController)
//    _animation  = CurvedAnimation( parent: _controller, curve: Curves )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        print("+++++++++++++++++++++++++++++++> $status");

        if (status == AnimationStatus.completed) {
        } else if (status == AnimationStatus.dismissed) {}
      });
    _showController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    _showAnimation = Tween(begin: 0.0, end: 1.0).animate(_showController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        print("+++++++++++++++++++++++++++++++> $status");
        if (status == AnimationStatus.completed) {
          setState(() {
            isUpShow = !isUpShow;
          });
          print("====>>>>>>");
//          _hideController.forward();
//          _showController.forward();

          Timer(Duration(milliseconds: 400), (){
            _scaleController.forward();
          });
        } else if (status == AnimationStatus.dismissed) {}
      });

    _scaleController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _scaleAnimation = Tween(begin: 1.0, end: 100.0).animate(_scaleController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
            // 跳转到首页
          Navigator.of(context).push(FadePageRouter(SearchPage(), duration: 1600));
        }
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 开启动画
      _hideController.forward();
      _showController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    var upAnimation = isUpShow ? _hideAnimation : _showAnimation;
    var downloadAnimation = !isUpShow ? _hideAnimation : _showAnimation;



    num upOpacity = upAnimation.value < 0 ? 0.0 : upAnimation.value;
    num downOpacity  =  downloadAnimation.value < 0 ? 0.0 : downloadAnimation.value;

    print(" ${isUpShow}》》》》》 ${upAnimation.value}        ${downloadAnimation.value}    -----  ${upOpacity}   ${downOpacity}");

    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: upOpacity,
              child: Transform.scale(
                alignment: Alignment.center ,
                origin: Offset(15.0, 10.0),
                scale: _scaleAnimation.value, child:Image.asset(
                "assets/images/wild2.png",
                width: 66.0,
              ),
              ),),
            Opacity(
              opacity: downOpacity,
              child: Container(
                margin: EdgeInsets.only(top: 26.0),
                child: Image.asset(
                  "assets/images/wild1.png",
                  fit: BoxFit.cover,
                  width: 66.0 * _scaleAnimation.value,
                ),
              ),
            ),

//            Opacity(
//              opacity: 1,
//              child: Container(
//                child: Transform.scale(
//                  alignment: Alignment.center ,
//                  origin: Offset(12.0, 10.0),
//                  scale: _scaleAnimation.value, child: Image.asset(
//                  "assets/images/wild2.png",
//                  fit: BoxFit.cover,
//                  height: 66.0,
//                ),)
//              ),
//            ),


          ],
        ),
      ),
    );
  }
}
