import 'package:cosmonaut/data/http/http_client.dart';
import 'package:cosmonaut/utils/security.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Http client should be singleton.', () {
    final h1 = HttpClient.instance;
    final h2 = HttpClient.instance;
    assert(identical(h1, h2));
    assert(h1 == h2);
  });

  test('Http client works.', () async {
    final res = await HttpClient.instance.get('http://www.baidu.com', (v) => v);
    debugPrint(res);
  });

  test('Crypto', () {
    debugPrint("HMAC digest as hex string: ${getSha256Digest('qwe123')}");
    debugPrint("MD5 digest as hex string: ${getMd5('qwe123')}");
  });
}
