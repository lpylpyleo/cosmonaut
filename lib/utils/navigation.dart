import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ---------- shorten navigation codes --------------- //
Future<T?>? goTo<T>(Widget page, {bool replace = false}) {
  if (replace) {
    Navigator.of(Get.context!).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
    return null;
  } else {
    return Navigator.of(Get.context!).push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }
}

Future<T?>? goToNamed<T>(String path,
    {Map<String, dynamic>? args, bool replace = false}) {
  if (replace) {
    Navigator.of(Get.context!).pushReplacementNamed(path, arguments: args);
    return null;
  } else {
    return Navigator.of(Get.context!).pushNamed<T>(path, arguments: args);
  }
}
// -------------------------------------------------- //