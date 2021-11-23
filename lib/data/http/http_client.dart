import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:cosmonaut/core/constants.dart';
import 'package:cosmonaut/core/router.dart';
import 'package:cosmonaut/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';

typedef Parser<T> = T Function(dynamic);

class HttpClient {
  static late Dio _dio;

  HttpClient._() {
    final _options = BaseOptions(
      baseUrl: 'http://106.15.196.195:8199',
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );
    _dio = Dio(_options);

    _dio.interceptors.add(
      CookieManager(
        PersistCookieJar(
          storage: FileStorage(C.appDocDir.absolute.path),
        ),
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          var msg = response.data;
          if (msg == "") {
            msg = "[EMPTY RESPONSE]";
          }
          msg = "${response.requestOptions.uri.path}: $msg";
          logger.fine(msg);
          handler.resolve(response);
        },
        onError: (error, handler) {
          logger.severe('${error.requestOptions.uri} ${error.response}');
          if (error is DioError && error.type == DioErrorType.response) {
            if (error.response?.statusCode == HttpStatus.forbidden) {
              Navigator.of(C.context).pushNamedAndRemoveUntil(Routes.login, (_) => false);
            }
          }
          handler.reject(error);
        },
      ),
    );
  }

  static final HttpClient _instance = HttpClient._();

  static HttpClient get instance => _instance;

  Future<T> get<T>(
    String path,
    Parser<T> parser, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final res = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    return parser(res.data);
  }

  Future<T> post<T>(
    String path,
    Parser<T> parser, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final res = await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return parser(res.data);
  }
}
