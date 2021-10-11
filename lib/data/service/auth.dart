import 'package:dio/dio.dart';

abstract class AuthService {
  Future<dynamic> signUp(String email, String password);
}
