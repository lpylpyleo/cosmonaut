// Named routes
import 'package:cosmonaut/pages/auth/login_page.dart';
import 'package:cosmonaut/pages/create_post_page.dart';
import 'package:cosmonaut/pages/main_page.dart';
import 'package:cosmonaut/pages/auth/register_page.dart';
import 'package:cosmonaut/pages/welcome.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  Routes.welcome: (_) => const WelcomePage(),
  Routes.register: (_) => const RegisterPage(),
  Routes.login: (_) => const LoginPage(),
  Routes.main: (_) => const MainPage(),
  Routes.createPost: (_) => const CreatePostPage(),
};

Map<String, dynamic>? _getArgs(BuildContext context) =>
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

class Routes {
  Routes._();

  static const welcome = '/welcome';
  static const register = '/register';
  static const login = '/login';
  static const main = '/home';
  static const createPost = '/post/create';
}
