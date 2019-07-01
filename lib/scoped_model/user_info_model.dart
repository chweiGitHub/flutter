
import 'package:flutter_app/inherited_demo/user_info.dart';
import 'package:scoped_model/scoped_model.dart';




class UserInfoModel  extends Model{


  UserInfo _userInfo;
  get data => _userInfo;

  UserInfoModel (){
    _userInfo  = UserInfo(1001, "emdd");
  }

  void updateUserName (String name){
    _userInfo  = UserInfo(_userInfo.id, name);
    notifyListeners();
  }



}