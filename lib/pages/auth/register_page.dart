import 'package:cosmonaut/core/router.dart';
import 'package:cosmonaut/core/styles.dart';
import 'package:cosmonaut/data/api.dart';
import 'package:cosmonaut/generated/l10n.dart';
import 'package:cosmonaut/utils/error_handler.dart';
import 'package:cosmonaut/utils/navigation.dart';
import 'package:cosmonaut/widgets/a_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final btnController = RoundedLoadingButtonController();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AText(
                  S.current.register,
                  fontSize: 24,
                ),
                const SizedBox(height: 32),
                Form(
                  child: Column(
                    children: [
                      input(
                        hint: 'Email',
                        iconData: FontAwesomeIcons.envelope,
                        onChanged: (value) => email = value,
                        obscure: false,
                      ),
                      input(
                        hint: 'Password',
                        iconData: FontAwesomeIcons.lock,
                        onChanged: (value) => password = value,
                        obscure: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                RoundedLoadingButton(
                  controller: btnController,
                  onPressed: _onSignUpPress,
                  width: mediaQueryData.size.width - 32,
                  borderRadius: 16,
                  color: Style.gold,
                  child: Center(
                    child: AText(
                      S.current.register,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AText(
                      S.current.already_have_account,
                      fontSize: 14,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateColor.resolveWith((states) => Style.gold),
                      ),
                      onPressed: () => goToNamed(Routes.login, replace: true),
                      child: AText(
                        S.current.login,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget input({
    required String hint,
    required IconData iconData,
    required ValueChanged<String> onChanged,
    required bool obscure,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Icon(
                iconData,
                color: Style.gold,
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              child: TextFormField(
                obscureText: obscure,
                onChanged: onChanged,
                style: const TextStyle(
                  fontSize: 16,
                  letterSpacing: 1,
                ),
                decoration: InputDecoration(
                  hintText: hint,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide.none),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onSignUpPress() async {
    await Api.auth.signUp(
      email.trim().toLowerCase(),
      password.trim(),
    ).then((v) {}).catchError(defaultApiErrorHandler).whenComplete(() => btnController.reset());
  }
}
