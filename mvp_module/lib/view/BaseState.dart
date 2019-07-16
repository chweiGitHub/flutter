


import 'package:flutter/material.dart';

import 'package:mvp_module/presenter/IBaseContact.dart';
// @author chenwei
// create at 2019/5/23
// description BaseState 用来集中处理Presenter的初始化和销毁。
abstract class BaseState<P extends IBasePresenter, T extends StatefulWidget> extends State<T> implements IBaseView{

   P presenter;

   // 加载中 进度弹框是否显示
   bool isShow =false;

   @override
  Widget build(BuildContext context) {
    return Text("base state view");
  }

  @override
  void initState() {
    super.initState();
    initPresenter();
  }



  @override
  void showLoading(bool){
     setState(() {
         isShow=bool;
     });
  }


  Widget initWidget(){

  }

  // 初始化presenter
  void initPresenter();


  // 销毁presenter 及 presenter中的view绑定。
  @override
  void dispose() {
    super.dispose();
    if(presenter != null){
      presenter.customDispose();
      presenter = null;
    }
  }
  @override
  void error(tag, String errorMsg) {
    //if (errorMsg != null && errorMsg.isNotEmpty) {
      //Utils.showToast(errorMsg);
    //}
  }
}