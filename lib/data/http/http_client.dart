import 'dart:convert';

import 'package:cosmonaut/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:http_parser/http_parser.dart';

typedef Parser<T> = T Function(dynamic);

class HttpClient {
  HttpClient._();

  factory HttpClient() => _instance;
  static final HttpClient _instance = HttpClient._();

  static HttpClient get instance => _instance;

  // Note: [_client] is never closed.
  static final _CosmonautClient _client = _CosmonautClient(
    // TODO: configure RetryClient
    RetryClient(
      http.Client(),
    ),
  );
  static final baseUrl = Uri.parse('http://106.15.196.195:8199');

  List<void Function(http.BaseRequest)> beforeRequestCallback = _client.beforeRequestCallback;
  List<void Function(http.StreamedResponse)> afterResponseCallback = _client.afterResponseCallback;
  List<CosmonautClientErrorHandler> onErrorCallback = _client.onErrorCallback;

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
      body: data?.map((key, value) => MapEntry(key, value.toString())), // value must be string.
    );
    return parser(res.utf8Body);
  }

  // TODO: support multiple files to upload.
  Future<T> upload<T>(
    String path,
    Parser<T> parser,
    String field,
    String filePath, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    MediaType? contentType,
  }) async {
    final request = http.MultipartRequest('POST', baseUrl.replace(path: path));
    if (data != null) {
      request.fields.addAll(data.map((key, value) => MapEntry(key, value.toString())));
    }

    request.files.add(
      await http.MultipartFile.fromPath(
        field,
        filePath,
        contentType: contentType ?? _guessMediaTypeFrom(filePath),
      ),
    );
    var streamedResponse = await _client.send(request);
    if (streamedResponse.statusCode == 200) {
      logger.fine('UPLOAD: $baseUrl$path SUCCESS.');
      final response = await http.Response.fromStream(streamedResponse);

      return parser(response.utf8Body);
    }

    throw CosmonautClientError(streamedResponse.statusCode);
  }

  MediaType _guessMediaTypeFrom(String filename) {
    var f = filename.toLowerCase();

    if (f.endsWith('png')) return MediaType('image', 'png');
    if (f.endsWith('jpg') || f.endsWith('jpeg')) return MediaType('image', 'jpg');
    if (f.endsWith('gif')) return MediaType('image', 'gif');

    return MediaType('application', 'octet-stream');
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

// FIXME: When there is no charset present in `Content-Type`, body decoding will not use utf-8.
// https://github.com/dart-lang/http/issues/175
extension HttpResponseExtension on http.Response {
  String get utf8Body => utf8.decode(bodyBytes);
}
