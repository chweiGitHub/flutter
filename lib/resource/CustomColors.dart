import 'package:flutter/material.dart';

// @author chenwei
// create at 2019/5/22
// description 定义app所用到的所有颜色
class CustomColors {
  // 主题色
  static Color colorPrimary = Color(0xff03B58A);

  // 标题栏被选中的颜色
  static Color colorNavigatorBarItemSeleced = Colors.lightBlue;

  // 标题栏未被选中的颜色
  static Color colorNavigatorBarItemUnSeleced = Colors.blue[200];

  // 页面标题的颜色
  static Color colorAppTitleText =
      Color(0xff444444); //Color.fromARGB(0, 255, 0, 0);

  static const Color gray_66 = Color(0xFF666666);

  // 列表分割线的颜色
  static const Color dividerColor = Color(0xFFf2f2f2);

  // tabbar 选中的字体颜色
  static Color tabBarSelectedFontColor = Color(0xff333333);

  // tabbar 未选中字体颜色
  static Color tabBarUnSelectedFontColor = Color(0xff333333);

  // 指示器的颜色
  static Color tabBarIndicatorColor = colorPrimary;

  // item 主标题的颜色
  static const Color itemTitleColor = Color(0xff333333);

  // item 副标题的颜色
  static const Color itemSubTitleColor = Color(0xff999999);

  // item 内容的颜色
  static const Color itemContentColor = Color(0xff777777);

  // item 灰色按钮的颜色
  static const Color itemActionGreyColor = Color(0xffbbbbbb);
  static const Color itemDateGreyColor = Color(0xff666666);

  static Color listItemTitleColor = Color(0xff777777);
  static Color listItemValueColor = Color(0xff333333);
  static Color cardItemColor = Color(0xff444444);

  static Color bgGreenColor = Color(0xfff4fffc);
  static Color bgGreyColor = Color(0xfffafafa);
  static Color userNameColor = Color(0xff222222);

  // 输入框边框 颜色
  static Color inputFieldBorderColor = Color(0xffDDDDDD);

  // 输入框底部下划线的 颜色
  static Color inputFieldBottomLineColor = Color(0xffCCCCCC);

  static Color boxShadowColor = Color(0x80e7e7e7);
  static Color genderItemBg = Color(0xffFCFCFC);

  // dlg
  static Color dlgContentColor = Color(0xff444444);
  static Color dlgConfirmColor = colorPrimary;
  static Color dlgCancelColor = Color(0xffAAAAAA);

  // 空页面文本颜色
  static Color emptyPageTextColor = Color(0xffAAAAAA);

  // 搜索任务输入框背景色
  static Color inputAreaBgColor = Color(0xffF8F8F8);

  // 状态颜色 -- 已完成
  static Color stateCompletedColor = Color(0xffFFA833);
  static Color searchIconColor = Color(0xffcccccc);
  static Color inputHintColor = Color(0xffbbbbbb);
  static Color userGroupTitleColor = Color(0xff666666);

  // 已结算  颜色
  static Color statePayTaskColor = Color(0xff999999);
  // 已完成  颜色
  static Color stateCompletedTaskColor = stateCompletedColor;
  // 进行中  颜色
  static Color stateUnderwayTaskColor = colorPrimary;
  // 待领取  颜色
  static Color statePendingTaskColor = colorPrimary;

  // toast 颜色
static Color toastBgColor = Color(0xff242424);
}
