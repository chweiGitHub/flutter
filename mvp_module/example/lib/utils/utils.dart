import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class Utils {

  static void showToastV2(String msg){
    Color toastBgColor = Color(0xff242424);
    num toastRadius = 2.0;
    showToast(
      "$msg",
      duration: Duration(seconds: 2),
      position: ToastPosition.center,
      backgroundColor: toastBgColor,// Colors.black.withOpacity(0.8),
      radius: toastRadius,
      textPadding: EdgeInsets.only(
        left: 42.0,
        top: 22.0,
        right: 42.0,
        bottom: 22.0,
      ),
      textStyle: TextStyle(fontSize: 12.0),
    );
  }

}
