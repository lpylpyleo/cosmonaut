import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

extension BuildContextExtension on BuildContext {
  NavigatorState get n => Navigator.of(this);
}
