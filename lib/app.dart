import 'package:cosmonaut/core/router.dart';
import 'package:cosmonaut/core/styles.dart';
import 'package:cosmonaut/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:bot_toast/bot_toast.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();

    return GetMaterialApp(
      title: "Cosmonaut",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.cyan,
        brightness: Brightness.dark,
        primaryColor: Style.gold,
        platform: TargetPlatform.iOS,
      ),
      localizationsDelegates: const [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('zh'),
      ],
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: (context, child) {
        return botToastBuilder(
          context,
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            child: child,
          ),
        );
      },
      routes: routes,
      initialRoute: Routes.welcome,
    );
  }
}
