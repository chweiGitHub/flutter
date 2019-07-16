

import 'package:dio/dio.dart';

abstract class IHttpCallBack<T> {
  void callBack (T res);

}