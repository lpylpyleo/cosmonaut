import 'dart:convert';

import 'package:cosmonaut/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

typedef Parser<T> = T Function(dynamic);

class HttpClient {
  // Note: [_client] is never closed.
  static final _CosmonautClient _client = _CosmonautClient(http.Client());
  static final baseUrl = Uri.parse('http://106.15.196.195:8199');

  List<void Function(http.BaseRequest)> beforeRequestCallback = _client.beforeRequestCallback;
  List<void Function(http.StreamedResponse)> afterResponseCallback = _client.afterResponseCallback;
  List<CosmonautClientErrorHandler> onErrorCallback = _client.onErrorCallback;

  HttpClient._();

  factory HttpClient() => _instance;

  static final HttpClient _instance = HttpClient._();

  static HttpClient get instance => _instance;

  Future<T> get<T>(
    String path,
    Parser<T> parser, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final res = await _client.get(
      baseUrl.replace(path: path, queryParameters: queryParameters),
    );
    return parser(res.utf8Body);
  }

  Future<T> post<T>(
    String path,
    Parser<T> parser, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final res = await _client.post(
      baseUrl.replace(path: path, queryParameters: queryParameters),
      body: data?.map((key, value) => MapEntry(key, value.toString())),
    );
    return parser(res.utf8Body);
  }
}

class _CosmonautClient extends http.BaseClient {
  final http.Client _inner;
  final List<Future<void> Function(http.BaseRequest)> beforeRequestCallback = [];
  final List<Future<void> Function(http.StreamedResponse)> afterResponseCallback = [];
  final List<CosmonautClientErrorHandler> onErrorCallback = [];

  _CosmonautClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    try {
      for (final fn in beforeRequestCallback) {
        await fn.call(request);
      }

      final response = await _inner.send(request);
      // TODO: Define which codes should be considered an error.
      // TODO: Support 30X redirection.
      if (response.statusCode >= 400) {
        throw CosmonautClientError(response.statusCode);
      }

      if (!kDebugMode) return response;
      final msg = '${request.method}: ${request.url}';
      logger.fine(msg);

      for (final fn in afterResponseCallback) {
        fn.call(response);
      }

      return response;
    } on CosmonautClientError catch (error) {
      logger.severe('${request.url}\n$error');
      for (final fn in onErrorCallback) {
        fn.call(error);
      }
      rethrow;
    } catch (error) {
      logger.severe('${request.url}\n$error');

      rethrow;
    }
  }
}

typedef CosmonautClientErrorHandler = Future<void> Function(CosmonautClientError);

class CosmonautClientError {
  final int httpStatusCode;
  final String? message;

  CosmonautClientError(this.httpStatusCode, [this.message]);

  @override
  String toString() {
    return 'CosmonautClientError{httpStatusCode: $httpStatusCode, message: $message}';
  }
}

// FIXME: When there is no charset present in `Content-Type`, body will use wrong encoding.
// https://github.com/dart-lang/http/issues/175
extension HttpResponseExtension on http.Response {
  String get utf8Body => utf8.decode(bodyBytes);
}
