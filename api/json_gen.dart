import 'dart:convert';
import 'dart:io';

import 'package:cosmonaut/data/api/auth.dart';
import 'package:cosmonaut/data/http/http_client.dart';
import 'package:path/path.dart' as path;

import 'config.dart' as cfg;

// ignore:avoid_print
void main() async {
  final client = HttpClient.instance;
  final auth = await Api.signIn(cfg.email, cfg.password);
  if (auth.error != null) {
    print(auth.error!.message);
    exit(1);
  }
  print('login success');
  final apis = getApiConfigs(client);
  final responses = await Future.wait(
    apis.map(
      (e) => e.request.then(
        (v) {
          if (v.error != null) throw v.error.message;
          return v.data;
        },
      ),
    ),
    eagerError: true,
  );

  if(File(cfg.jsonDir).existsSync()) {
    print('jsonDir does not exist. '
        'Please Check if the directory is created and you are run this script under project root directory.');
    exit(2);
  }
  for (int i = 0; i < apis.length; i++) {
    final jsonFile = File(path.join(cfg.jsonDir, '${apis[i].filename}.json'));
    jsonFile.writeAsStringSync(jsonEncode(responses[i]));
  }

  print('process success');
  exit(0);
}

List<ApiConfig> getApiConfigs(HttpClient client) => [
      // ApiConfig(
      //   filename: 'posts',
      //   request: client.rpc('get_latest_posts').execute(),
      // ),
    ];

class ApiConfig {
  final String filename;
  final Future request;

  ApiConfig({
    required this.filename,
    required this.request,
  });
}
