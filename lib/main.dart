import 'dart:developer';

import 'package:cosmonaut/core/router.dart';
import 'package:cosmonaut/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: SystemUiOverlay.values);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    log('${record.time}: ${record.message}', name: record.level.name);
  });

  await Firebase.initializeApp();
  FirebaseAuth.instance.idTokenChanges().listen((User? user) {
    if (user == null) {
      logger.info('User is currently signed out!');
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Get.offAllNamed(Routes.login, predicate: (route) => false);
      });
    } else {
      logger.info('User is signed in!');
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Get.offAllNamed(Routes.main, predicate: (route) => false);
      });
    }
  });

  runApp(const MyApp());
}
