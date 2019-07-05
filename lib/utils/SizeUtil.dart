import 'package:flutter_screenutil/flutter_screenutil.dart';
// @author chenwei
// create at 2019/5/23
// description 屏幕适配的util .
class SizeUtil {
  // 设置左右的边距 or 宽度
  static getWidth(double size) {
    return ScreenUtil().setWidth(size);
  }

  // 获取上下的边距 or 高度
  static getHeight(double size) {
    return ScreenUtil().setWidth(size);
  }

  // 获取字体大小
  static getFontSize(double fontSize) {
    return fontSize; //ScreenUtil().setSp(fontSize);
  }
}
