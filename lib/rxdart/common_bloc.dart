import 'dart:async';

import 'package:flutter_app/rxdart/provider.dart';
import 'package:rxdart/rxdart.dart';

import 'mode.dart';

/// 一个基础的bloc, 包含各个部分要用到的数据及操作
/// 定义不同的Stream, StreamController
class CommonBloc implements BaseBloc {
//
//  BehaviorSubject<List<UserItemInfo>> userListController = BehaviorSubject<List<UserItemInfo>>();
//
//  Sink<List<UserItemInfo>>   userListSink  = userListController.sink;

  BehaviorSubject<List<UserItemInfo>> _banner =
      BehaviorSubject<List<UserItemInfo>>();

  Sink<List<UserItemInfo>> get _bannerSink => _banner.sink;

  Stream<List<UserItemInfo>> get bannerStream => _banner.stream;

  void getUserList (){
    Timer (Duration(seconds: 2), (){

    });
  }

  @override
  void dispose() {
    _banner.close();
  }
}
