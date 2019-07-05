import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page/search_page.dart';
import 'package:flutter_app/resource/ResIndex.dart';
import 'package:flutter_app/widget/scale_page_router.dart';

import 'SizeUtil.dart';

/// @author chenwei
/// create at 2019/5/29
/// description 确认弹框
void showConfirmDlg(context, showInfo, confirmFun, {String title}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(SizeUtil.getWidth(Dimens.size_12)))),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(SizeUtil.getWidth(Dimens.size_12))),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
//              alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    left: SizeUtil.getWidth(Dimens.stard_margin_lr),
                    right: SizeUtil.getWidth(Dimens.stard_margin_lr),
                    top: SizeUtil.getWidth(Dimens.size_38),
                    bottom: SizeUtil.getWidth(Dimens.size_38),
                  ),
                  child: Text(
                    showInfo,
                    style: TextStyle(
                        color: CustomColors.dlgContentColor,
                        fontSize: SizeUtil.getFontSize(Dimens.font_sp16),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeUtil.getWidth(Dimens.size_24)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            if (confirmFun is Function) {
                              confirmFun();
                            }
                            Navigator.of(context).pop();
                          },
                          child: Center(
                            child: Text(
                              Strings.dlgConfirm,
                              style: TextStyle(
                                color: CustomColors.dlgConfirmColor,
                                fontSize:
                                    SizeUtil.getFontSize(Dimens.font_sp16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: CustomColors.dividerColor,
                        width: SizeUtil.getWidth(Dimens.divider_height),
                        height: SizeUtil.getWidth(Dimens.size_24),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Center(
                            child: Text(
                              Strings.dlgCancle,
                              style: TextStyle(
                                color: CustomColors.dlgCancelColor,
                                fontSize:
                                    SizeUtil.getFontSize(Dimens.font_sp16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}

// 从底部弹出的对话框
void showRemindDlg(
  BuildContext context,
) {
  showGeneralDialog(
    context: context,
    barrierLabel: "",
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 500),
    barrierDismissible: true,
    pageBuilder: (BuildContext context, Animation animation,
        Animation secondaryAnimation) {
      return Center(
        child: Image.asset("assets/images/food01.jpeg"),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return ScaleTransition(
        alignment: Alignment.bottomCenter, // 添加这个
        scale: anim,
        child: child,
      );
    },
  );
}
