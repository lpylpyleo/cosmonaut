import 'package:cosmonaut/data/http/http_client.dart';
import 'package:cosmonaut/utils/logger.dart';

class Api {
  static Future signUp(String email, String password) async {
    final res = await HttpClient.instance.post('/api/v1/user/sign-up', data: {
      'email': email,
      'password': password,
    });
    logger.fine(res.data);
  }

  static Future signIn(String email, String password) async {
    final res = await HttpClient.instance.post('/api/v1/user/sign-in', data: {
      'email': email,
      'password': password,
    });
    logger.fine(res.data);
  }
}
