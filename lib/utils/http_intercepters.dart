import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:cosmonaut/core/constants.dart';
import 'package:cosmonaut/core/router.dart';
import 'package:cosmonaut/data/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final cookieJar = PersistCookieJar(storage: FileStorage(C.appDocDir.absolute.path));

Future<void> appendCookies(http.BaseRequest request) async {

  final cookies = await cookieJar.loadForRequest(request.url);

  var cookie = _getCookies(cookies);
  if (cookie.isNotEmpty) {
    request.headers[HttpHeaders.cookieHeader] = cookie;
  }
}

Future<void> saveCookies(http.StreamedResponse response) async {
  // FIXME: Package `http`'s header cannot handle duplicate headers correctly.
  // See https://github.com/dart-lang/http/issues/362
  var cookies = response.headers[HttpHeaders.setCookieHeader];

  if (cookies != null) {
    await cookieJar.saveFromResponse(
      response.request!.url,
      [Cookie.fromSetCookieValue(cookies)],
    );
  }
}

String _getCookies(List<Cookie> cookies) {
  return cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
}

Future<void> authInterceptor(CosmonautClientError error) async {
  if (error.httpStatusCode == HttpStatus.forbidden) {
    Navigator.of(C.context).pushNamedAndRemoveUntil(Routes.login, (_) => false);
  }
}