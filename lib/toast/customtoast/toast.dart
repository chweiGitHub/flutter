import 'package:flutter/material.dart';
import 'package:flutter_app/toast/customtoast/global_context.dart';

/*
弹出toast
 */
void showToast(String message, {int duration, BuildContext context}) {
  context ??= GlobalContext.context;

  Color toastBgColor = Color(0xff242424);
  num toastRadius = 2.0;
  OverlayEntry entry = OverlayEntry(builder: (context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: Material(
//            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          borderRadius: BorderRadius.all(Radius.circular(toastRadius)),
          shadowColor: toastBgColor,
          color: toastBgColor,
          child: Container(
            padding: EdgeInsets.only(
              left: 42.0,
              top: 22.0,
              right: 42.0,
              bottom: 22.0,
            ),
            decoration: BoxDecoration(
                color: toastBgColor,
                borderRadius: BorderRadius.all(Radius.circular(toastRadius))),
            child: Text(
              message,
              style: TextStyle(
                  color: Colors.white,
//                    fontWeight: FontWeight.bold,
                  fontSize: 12.0),
            ),
          ),
        ),
      ),
    );
  });

  Overlay.of(context).insert(entry);
  Future.delayed(Duration(seconds: duration ?? 2)).then((value) {
    // 移除层可以通过调用OverlayEntry的remove方法。
    entry.remove();
  });
}
