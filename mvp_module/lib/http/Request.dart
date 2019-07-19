// @author chenwei
// create at 2019/5/23
// description 网络请求dio， post /get ,文件上传等。
import 'dart:io';

import 'package:dio/dio.dart';
import 'dart:convert';

class Request {
  static final mode = 0; // 0 测试服  1 正式服

  static final _host = ['https://ygyapp.paat.vip', 'https://ygyapp.paat.com'];
  static final _keys = [
    '9uxxPbd3jvgE4gTB1LD5RlDwKNj9eFBX',
    '---'
  ];

  static _getBaseUrl() {
    return _host[mode] + '';
  }

  // 加密用的key
  static getKeys() {
    return _keys[mode];
  }

  static final BaseOptions _options = BaseOptions(
      contentType: ContentType.json,
      baseUrl: _getBaseUrl(),
      connectTimeout: 60000,
      receiveTimeout: 60000,
      followRedirects: true);
  static final Dio _dio = Dio(_options);

  // 网络请求
  static Future<Response<T>> _request<T>(
      String url, String method, Map<String, dynamic> params) async {
    print("请求参数-：$url $method-->\n" + json.encode(params));
    try {
      Response<T> response;
      if ("get" == method) {
        response = await _dio.get<T>(url, queryParameters: params);
      } else if ("post" == method) {
        response = await _dio.post<T>(url, data: params);
      } else {
        response = null;
      }
      if (mode == 0) {
        print("返回--$url: ");
        print(response);
      }
      return response;
    } catch (e) {
      print(e);
      return null;
      return e;
    }
  }

  // post 请求
  static Future<Response> postRequest<T>(
      String url, Map<String, dynamic> params) async {
    return _request<T>(url, "post", params);
  }

  // get 请求
  static Future<Response> getRequest<T>(
      String url, Map<String, dynamic> params) async {
    return _request<T>(url, "get", params);
  }

  // 文件上传
  // https://fileserver.paat.com/file/upload
  static Future<Response> uploadFile(File file, String url) {
    return _dio.post(url,
        data: FormData.from({"file": UploadFileInfo(file, file.path)}));
  }

  // 下载文件
  static Future<Response> downloadFile(String url, String savePath,
      {onProgress}) async {
    return _dio.download(url, savePath, onReceiveProgress: onProgress);
  }
}
