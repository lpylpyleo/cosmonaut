import 'dart:developer';

import 'package:cosmonaut/data/http/http_client.dart';
import 'package:cosmonaut/utils/http_intercepters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'core/constants.dart';

void main() async {
  await _init();
  runApp(const MyApp());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();

  // System UI
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: SystemUiOverlay.values);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  // Logger
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    log('${record.time}: ${record.message}', name: record.level.name);
  });

  C.appDocDir = await getApplicationDocumentsDirectory();

  // Http Client
  HttpClient.instance.beforeRequestCallback.add(appendCookies);
  HttpClient.instance.afterResponseCallback.add(saveCookies);
  HttpClient.instance.onErrorCallback.add(authInterceptor);
}
