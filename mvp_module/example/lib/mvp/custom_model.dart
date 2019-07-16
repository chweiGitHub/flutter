
import 'package:mvp_module/model/BaseModel.dart';
import 'package:mvp_module/http/Request.dart';

class CustomModel extends BaseModel {

  @override
  Map<String, dynamic> getBaseParams() {
    Map<String, dynamic> baseParams = Map ();
//    baseParams['deviceId'] = AccountManager.instance.deviceId;
//    var sendTime = getSendTime();
//    baseParams['sendTime'] = "$sendTime";
//    String signStr =
//        "${AccountManager.instance.deviceId}$sendTime${Request.getKeys()}";
//    baseParams['sign'] = getMd5String(signStr);
    return baseParams;
  }

  @override
  Map<String, dynamic> getBaseSignParams() {
    Map<String, dynamic> params = Map ();
//    params['accessToken'] = AccountManager.instance.token;
//    params['deviceId'] = AccountManager.instance.deviceId;
//    var sendTime = getSendTime();
//    params['sendTime'] = sendTime;
//    String signStr =
//        "${AccountManager.instance.deviceId}$sendTime${Request.getKeys()}";
//    params['sign'] = getMd5String(signStr);
    return params;
  }
}
