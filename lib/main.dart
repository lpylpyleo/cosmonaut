import 'dart:developer';

import 'package:cosmonaut/core/router.dart';
import 'package:cosmonaut/utils/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gotrue/gotrue.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/constants.dart';

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

  await Supabase.initialize(
    url: C.supabaseUrl,
    anonKey: C.supabaseAnnonKey,
    authCallbackUrlHostname: 'login-callback', // optional
  );

  Supabase.instance.client.auth.onAuthStateChange((event, session) {
    logger.info('onAuthStateChange: $event.');

    switch(event){
      case AuthChangeEvent.signedIn:
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Get.offAllNamed(Routes.main, predicate: (_) => false);
        });
        break;
      case AuthChangeEvent.signedOut:
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          Get.offAllNamed(Routes.login, predicate: (_) => false);
        });
        break;
      case AuthChangeEvent.userUpdated:
        break;
      case AuthChangeEvent.passwordRecovery:
        break;
    }
  });

  runApp(const MyApp());
}
