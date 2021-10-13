import 'dart:async';

import 'package:cosmonaut/widgets/a_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cosmonaut/core/constants.dart';

import 'logger.dart';

FutureOr<Null> defaultApiErrorHandler(dynamic error) {
  late String msg;
  if (error is DioError && error.type == DioErrorType.response) {
    final data = error.response?.data;
    logger.severe(error.requestOptions.data);
    logger.severe(data);
    msg = data is Map ? data['message'] : data.toString();
  } else {
    msg = error.toString();
  }
  showDialog(context: C.context, builder: (_) => ADialog(title: msg));
}
