import 'package:cosmonaut/data/http/http_client.dart';
import 'package:cosmonaut/utils/logger.dart';

class Api {
  static Future signUp(String email, String password, String password2) async {
    final res = await HttpClient.instance.post('/user/sign-up', data: {
      'passport': email,
      'password': password,
      'password2': password2,
    });
    logger.fine(res.data);
  }
}
