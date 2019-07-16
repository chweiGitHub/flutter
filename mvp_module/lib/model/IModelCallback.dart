



/// @author chenwei
/// create at 2019-06-14
/// description 接口请求返回的回调
  class IModelCallback {
  /*正常的数据返回*/
  void success(dynamic tag, dynamic response){}

  /*token过期or error  */
  void onTokenError(){}

  /* 出错--网络超时等 */
  void error(dynamic tag, String errorMsg){}
}
