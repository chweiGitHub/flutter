import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mvp_module/model/IModelCallback.dart';
import 'package:mvp_module/http/Request.dart';

class BaseModel {
  // TOKEN过期 or error
  static final int ERROR_TOKEN = 99;

  // 接口正确返回
  static final int REQUEST_SUCCESS = 0;

  /*获取基础统一参数*/
  Map<String, dynamic> getBaseParams() {
    return Map();
  }

  /*获取基础统一参数--和用户相关*/
  Map<String, dynamic> getBaseSignParams() {
    return Map();
  }

  // 下载文件
  Future<Response> downloadFile(String url, String savePath,
      {onProgress}) async {
    return Request.downloadFile(url, savePath, onProgress: onProgress);
  }

  // --------------------- 重构网络返回 start -------------------------

  void getRequest<J>(
      String url, Map<String, dynamic> params, IModelCallback callback, tag) {
    params ??= Map();
    if (getBaseParams() != null) {
      params.addAll(getBaseParams());
    }
    Request.getRequest<J>(url, params).then((Response res) {
      dealResult(res, callback, tag);
    });
  }

  void getRequestCheckSign<J>(
      String url, Map<String, dynamic> params, IModelCallback callback, tag) {
    params ??= Map();
    if (getBaseParams() != null) {
      params.addAll(getBaseSignParams());
    }
    Request.getRequest(url, params).then((Response res) {
      dealResult(res, callback, tag);
    });
  }

  /*post 请求 -- 不需要用户登录 */
  void postRequest<J>(String url, Map<String, dynamic> params,
      IModelCallback callback, tag) async {
    params ??= Map();
    if (getBaseParams() != null) {
      params.addAll(getBaseParams());
    }
    Request.postRequest(url, params).then((Response res) {
      dealResult(res, callback, tag);
    });
  }

  /*post 请求 -- 需用验证用户身份 */
  void postRequestCheckSign(String url, Map<String, dynamic> params,
      IModelCallback callback, dynamic tag) async {
    params ??= Map();
    if (getBaseSignParams() != null) {
      params.addAll(getBaseSignParams());
    }
    Request.postRequest(url, params).then((Response res) {
      dealResult(res, callback, tag);
    });
  }

  /*
  * 统一处理接口返回来的数据
  * 可以通过重写该方法来统一处理接口返回逻辑
  * */
  void dealResult(Response response, IModelCallback callback, tag) {
    if (response != null) {
//      if (response.statusCode == 200) {
//        if (callback != null) {
//          int code = response.data['state'];
//          if (code == REQUEST_SUCCESS) {
//            callback.success(tag, response.data);
//          } else if (code == ERROR_TOKEN) {
//            callback.onTokenError();
//          } else {
//            callback.error(tag, response.data['msg']);
//          }
//        }
//      } else {
//        if (callback != null) {
//          callback.error(tag, response.statusMessage);
//        }
//      }
    callback.success(tag, response);
    } else {
      if (callback != null) {
        callback.error(tag, "请求失败！");
      }
    }
  }

// --------------------- 重构网络返回 end -------------------------

}
