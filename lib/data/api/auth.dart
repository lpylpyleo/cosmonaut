part of '../api.dart';

class Auth {
  Future signUp(String email, String password) async {
    return HttpClient.instance.post('/api/v1/user/sign-up', data: {
      'email': email,
      'password': password,
    });
  }

  Future signIn(String email, String password) async {
    return HttpClient.instance.post('/api/v1/user/sign-in', data: {
      'email': email,
      'password': password,
    });
  }

  Future signOut() async {
    return HttpClient.instance.post('/api/v1/user/sign-out');
  }
}
