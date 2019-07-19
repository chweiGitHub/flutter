import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_common_widget/resource/index.dart';
import 'package:flutter_common_widget/utils/index.dart';

/// @author chenwei
/// create at 2019-07-18
/// description 确认弹框
/// showInfo --- 要显示的内容， 可以是字符串，也可以是自定义的组件
/// confirmFun --- 确认按钮的回调方法
/// customActionWidget --- 用户自定义的按钮列表
/// showAction --- 是否显示按钮
void showConfirmDlg(
  context,
  showInfo, {
  Function confirmFun,
  Widget customActionWidget,
  bool showAction = true,
  bool barrierDismissible = true,
}) {
  Widget showInfoView;
  if (showInfo is String) {
    showInfoView = Text(
      showInfo,
      style: TextStyle(
          color: CustomColors.dlgContentColor,
          fontSize: getCustomFontSize(Dimens.font_sp16),
          fontWeight: FontWeight.bold),
    );
  } else if (showInfo is Widget) {
    showInfoView = showInfo;
  } else {
    showInfoView = Container();
  }
  Widget actionsView;
  if (customActionWidget == null) {
    actionsView = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: getCustomWidth(Dimens.size_24)),
              child: Text(
                Strings.dlgCancle,
                style: TextStyle(
                  color: CustomColors.dlgCancelColor,
                  fontSize: getCustomFontSize(Dimens.font_sp16),
                ),
              ),
            ),
          ),
        ),
        Container(
          color: CustomColors.dividerColor,
          width: getCustomWidth(Dimens.divider_height),
          height: getCustomWidth(Dimens.size_24),
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              if (confirmFun is Function) {
                confirmFun();
              }
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: getCustomWidth(Dimens.size_24)),
              child: Text(
                Strings.dlgConfirm,
                style: TextStyle(
                  color: CustomColors.dlgConfirmColor,
                  fontSize: getCustomFontSize(Dimens.font_sp16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  } else {
    actionsView = customActionWidget;
  }
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => AlertDialog(
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(getCustomWidth(Dimens.size_12)))),
      content: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(getCustomWidth(Dimens.size_12))),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
//              alignment: Alignment.center,
              padding: EdgeInsets.only(
                left: getCustomWidth(Dimens.stard_margin_lr),
                right: getCustomWidth(Dimens.stard_margin_lr),
                top: getCustomWidth(Dimens.size_38),
                bottom: getCustomWidth(Dimens.size_38),
              ),
              child: showInfoView,
            ),
            Offstage(
              offstage: !showAction,
              child: actionsView,
            ),
          ],
        ),
      ),
    ),
  );
}

/// 可自动关闭的显示提醒的弹框   --- 如： 领取任务成功、完成任务成功等。
/// showInfo --- 显示的内容，可以是字符串， 也可以是组件Widget
/// remindIcon --- icon
/// duration --- 自动消失的时间， 如果为null不会自动关闭
void showCenterRemindDlg(
  BuildContext context,
  showInfo, {
  Widget remindIcon,
  Duration duration = const Duration(seconds: 1),
}) {
  Widget showInfoView;
  if (showInfo is String) {
    showInfoView = Text(
      showInfo,
      style: TextStyle(
          color: CustomColors.dlgContentColor,
          fontSize: getCustomFontSize(Dimens.font_sp16),
          fontWeight: FontWeight.bold),
    );
  } else if (showInfo is Widget) {
    showInfoView = showInfo;
  } else {
    showInfoView = Container();
  }

  remindIcon = remindIcon == null
      ? Icon(Icons.timer, size: 28.0, color: Colors.lightBlue)
      : remindIcon;
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
            contentPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(getCustomWidth(Dimens.size_12)))),
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(getCustomWidth(Dimens.size_12))),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.only(top: getCustomWidth(Dimens.size_24)),
                    child: remindIcon,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: getCustomWidth(Dimens.stard_margin_lr),
                      right: getCustomWidth(Dimens.stard_margin_lr),
                      top: getCustomWidth(Dimens.size_18),
                      bottom: getCustomWidth(Dimens.size_24),
                    ),
                    child: showInfoView,
                  ),
                ],
              ),
            ),
          ));
  if (duration != null) {
    Timer(duration, () {
      Navigator.of(context).pop();
    });
  }
}

/// 底部弹框
/// contentView 如果为空，就显示demo。
void showBottomDlg(BuildContext context, Widget contentView) {
  contentView ??= Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      SimpleDialogOption(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            top: getCustomWidth(Dimens.size_14),
            bottom: getCustomWidth(Dimens.size_10),
          ),
          child: Text(
            Strings.genderMale,
            style: TextStyle(
              color: CustomColors.colorPrimary,
              fontSize: getCustomFontSize(Dimens.font_sp16),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      Divider(
        color: CustomColors.dividerColor,
        height: Dimens.divider_height,
      ),
      SimpleDialogOption(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            top: getCustomWidth(Dimens.size_14),
            bottom: getCustomWidth(Dimens.size_10),
          ),
//                      color: CustomColors.genderItemBg,
          child: Text(
            Strings.genderFemal,
            style: TextStyle(
              color: CustomColors.colorPrimary,
              fontSize: getCustomFontSize(Dimens.font_sp16),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
  showModalBottomSheet(
    context: context,
    builder: (context) => CommonBottomDlgView(
      contentWidget: contentView,
    ),
  );
}

/// @author chenwei
/// create at 2019-07-09
/// 底部弹出的选择弹框通用模板widget
class CommonBottomDlgView extends StatelessWidget {
  final Widget contentWidget;

  const CommonBottomDlgView({Key key, this.contentWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(getCustomWidth(Dimens.size_12))),
            ),
            child: contentWidget,
          ),
          Divider(
            color: Colors.transparent,
            height: getCustomHeight(Dimens.size_6),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(getCustomWidth(Dimens.size_12)),
                topRight: Radius.circular(getCustomWidth(Dimens.size_12)),
              ),
            ),
            child: SimpleDialogOption(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  top: getCustomWidth(Dimens.size_14),
                  bottom: getCustomWidth(Dimens.size_10),
                ),
                child: Text(
                  Strings.dlgCancle,
                  style: TextStyle(
                    color: CustomColors.itemSubTitleColor,
                    fontSize: getCustomFontSize(Dimens.font_sp16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
