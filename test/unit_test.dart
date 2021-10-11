
import 'dart:convert';

import 'package:cosmonaut/data/http/http_client.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Http client should be singleton.', () {
    final h1 = HttpClient.instance;
    final h2 = HttpClient.instance;
    assert(identical(h1, h2));
    assert(h1 == h2);
  });

  test('Http client works.', () async{
    final res = await HttpClient.instance.get('http://www.baidu.com');
    debugPrint(res.data.toString());
  });

  test('Crypto', (){
    var key = utf8.encode('p@ssw0rd');
    var bytes = utf8.encode("foobar");

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);

    debugPrint("HMAC digest as bytes: ${digest.bytes}");
    debugPrint("HMAC digest as hex string: $digest");
  });
}
