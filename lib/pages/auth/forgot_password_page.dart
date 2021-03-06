import 'package:cosmonaut/core/router.dart';
import 'package:cosmonaut/core/styles.dart';
import 'package:cosmonaut/generated/l10n.dart';
import 'package:cosmonaut/widgets/a_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final btnController = RoundedLoadingButtonController();
  String email = '';

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
                  S.current.forgot_password,
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
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                RoundedLoadingButton(
                  controller: btnController,
                  onPressed: _onResetPasswordPress,
                  width: mediaQueryData.size.width - 32,
                  borderRadius: 16,
                  color: AppPalette.gold,
                  child: Center(
                    child: AText(
                      S.current.reset,
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
                        foregroundColor: MaterialStateColor.resolveWith((states) => AppPalette.gold),
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
                color: AppPalette.gold,
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

  void _onResetPasswordPress() async {

  }
}
