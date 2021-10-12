import 'package:cookie_jar/cookie_jar.dart';
import 'package:cosmonaut/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class HttpClient {
  static late Dio _dio;

  HttpClient._() {
    logger.fine('init http');
    final _options = BaseOptions(
      baseUrl: 'http://192.168.1.15:8199',
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );
    _dio = Dio(_options);
    _dio.interceptors.add(CookieManager(CookieJar()));
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


