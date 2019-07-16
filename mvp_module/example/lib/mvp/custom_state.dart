
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mvp_module/index.dart';
import 'package:example/utils/utils.dart';





/// @author chenwei
/// create at 2019-06-15
/// description
abstract class CustomState<P extends IBasePresenter, T extends StatefulWidget> extends BaseState<P, T>{


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: initWidget(),
      inAsyncCall: isShow,
    );
  }

  @override
  void logout() {
    // 跳转到登录页面
    // todo
    print("跳转到登录页面");
  }



  @override
  void error(tag, String errorMsg) {
    // 统一的接口error提示，特殊处理可重写该方法
    if (errorMsg != null && errorMsg.isNotEmpty) {
      Utils.showToastV2(errorMsg);
    }
  }
}