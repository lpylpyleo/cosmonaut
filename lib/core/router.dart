// Named routes
import 'package:cosmonaut/pages/auth/sign_in_page.dart';
import 'package:cosmonaut/pages/create_post_page.dart';
import 'package:cosmonaut/pages/main_page.dart';
import 'package:cosmonaut/pages/auth/sign_up_page.dart';
import 'package:cosmonaut/pages/post_detail_page.dart';
import 'package:cosmonaut/pages/profile_edit.dart';
import 'package:cosmonaut/pages/welcome.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  Routes.welcome: (_) => const WelcomePage(),
  Routes.register: (_) => const RegisterPage(),
  Routes.login: (_) => const LoginPage(),
  Routes.main: (_) => const MainPage(),
  Routes.createPost: (_) => const CreatePostPage(),
  Routes.postDetail: (c) => PostDetailPage(postId: _getArgs(c)!['postId']),
  Routes.editProfile: (_) => const ProfileEditPage(),
};

Map<String, dynamic>? _getArgs(c) => ModalRoute.of(c)!.settings.arguments as Map<String, dynamic>?;

class Routes {
  Routes._();

  static const welcome = '/welcome';
  static const register = '/register';
  static const login = '/login';
  static const main = '/home';
  static const createPost = '/post/create';
  static const postDetail = '/post/detail';
  static const editProfile = '/profile/edit';
}



// ---------- shorten navigation codes --------------- //
Future<T?> goTo<T>(Widget page, {bool replace = false}) {
  if (replace) {
    return Navigator.of(C.context!).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  } else {
    return Navigator.of(C.context!).push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }
}

Future<T?> goToNamed<T>(String path,
    {Map<String, dynamic>? args, bool replace = false}) {
  if (replace) {
    return Navigator.of(C.context!).pushReplacementNamed(path, arguments: args);
  } else {
    return Navigator.of(C.context!).pushNamed<T>(path, arguments: args);
  }
}

void goBack<T>([T? result]) {
  Navigator.of(C.context!).pop(result);
}
// -------------------------------------------------- //