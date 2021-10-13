import 'package:cosmonaut/core/constants.dart';
import 'package:flutter/material.dart';

// ---------- shorten navigation codes --------------- //
Future<T?>? goTo<T>(Widget page, {bool replace = false}) {
  if (replace) {
    Navigator.of(C.context!).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
    return null;
  } else {
    return Navigator.of(C.context!).push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }
}

Future<T?>? goToNamed<T>(String path,
    {Map<String, dynamic>? args, bool replace = false}) {
  if (replace) {
    Navigator.of(C.context!).pushReplacementNamed(path, arguments: args);
    return null;
  } else {
    return Navigator.of(C.context!).pushNamed<T>(path, arguments: args);
  }
}

void goBack<T>([T? result]) {
  Navigator.of(C.context!).pop(result);
}
// -------------------------------------------------- //