import 'dart:async';

import 'package:cosmonaut/widgets/a_dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

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
  Get.dialog(ADialog(title: msg));
}
