import 'dart:convert';

import 'package:cosmonaut/core/constants.dart';
import 'package:crypto/crypto.dart';

String getSha256Digest(String src) {
  var key = utf8.encode(C.appName + C.signSuffix);
  var bytes = utf8.encode(src);
  var hmacSha256 = Hmac(sha256, key);
  return hmacSha256.convert(bytes).toString();
}

String getMd5(String src){
  return md5.convert(utf8.encode(src)).toString();
}