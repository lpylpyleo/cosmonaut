part of '../api.dart';

class Auth {
  Future<bool> signUp(String email, String password) async {
    return HttpClient.instance.post(
      '/api/v1/user/sign-up',
      HttpUtil.emptyResponse,
      data: {
        'email': email,
        'password': password,
      },
    );
  }

  Future signIn(String email, String password) async {
    return HttpClient.instance.post(
      '/api/v1/user/sign-in',
      HttpUtil.emptyResponse,
      data: {
        'email': email,
        'password': password,
      },
    );
  }

  Future signOut() async {
    return HttpClient.instance.post(
      '/api/v1/user/sign-out',
      HttpUtil.emptyResponse,
    );
  }
}
