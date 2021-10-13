import 'package:cookie_jar/cookie_jar.dart';
import 'package:cosmonaut/core/constants.dart';
import 'package:cosmonaut/core/router.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';

class _ErrorCode {
  static const needLogin = 10403;
}

class HttpClient {
  static late Dio _dio;

  HttpClient._() {
    final _options = BaseOptions(
      baseUrl: 'http://192.168.1.15:8199',
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
        onError: (error, handler) {
          if (error is DioError && error.type == DioErrorType.response) {
            if (error.response?.data is Map) {
              if (error.response!.data['code'] == _ErrorCode.needLogin) {
                Navigator.of(C.context).pushNamedAndRemoveUntil(Routes.login, (_) => false);
              }
            }
          }
        },
      ),
    );
  }

  static final HttpClient _instance = HttpClient._();

  static HttpClient get instance => _instance;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }
}
