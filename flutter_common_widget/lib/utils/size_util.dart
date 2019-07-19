import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @author chenwei
/// create at 2019-07-17
/// description 屏幕适配
///
class SizeUtil {
  static void init(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 667)..init(context);
  }
}

//class SizeUtil {
// 设置左右的边距 or 宽度
getCustomWidth(double size) {
  return ScreenUtil().setWidth(size);
}

// 获取上下的边距 or 高度
getCustomHeight(double size) {
  return ScreenUtil().setHeight(size);
}

// 获取字体大小
getCustomFontSize(double fontSize) {
  return ScreenUtil().setSp(fontSize);
}
//}
