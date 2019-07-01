import 'package:flutter/services.dart';

void cPrint(String msg) {
  print("===================================->");
  print("$msg");
  print("<-===================================");
}

const String channel = "custom_plugin";

void showAndroidToast(String msg) {
  MethodChannel methodChannel = MethodChannel(channel);

  // 调用原生的showToast方法，并传递复杂类型参数
  methodChannel.invokeMethod<bool>("showToast",
    {
      "values": ["aaa", "bbb","ccc"],
    }
  ).then((value) {
    cPrint("$value");
  });
}
