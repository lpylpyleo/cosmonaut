import 'package:cosmonaut/core/constants.dart';
import 'package:cosmonaut/core/router.dart';
import 'package:cosmonaut/core/styles.dart';
import 'package:cosmonaut/data/provider.dart';
import 'package:cosmonaut/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileNotifier()),
        ChangeNotifierProvider(create: (_) => PostNotifier()),
      ],
      child: MaterialApp(
        title: C.appName,
        debugShowCheckedModeBanner: false,
        navigatorKey: C.navigationKey,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: AppPalette.gold,
          platform: TargetPlatform.iOS,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
          ),
          iconTheme: const IconThemeData(
            color: AppPalette.gold,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppPalette.gold,
          ),
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
          return botToastBuilder(context, child);
        },
        routes: routes,
        initialRoute: Routes.welcome,
      ),
    );
  }
}
