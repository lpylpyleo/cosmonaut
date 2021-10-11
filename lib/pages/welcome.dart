import 'dart:async';

import 'package:cosmonaut/core/router.dart';
import 'package:cosmonaut/core/styles.dart';
import 'package:cosmonaut/widgets/a_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.login, predicate: (_) => false);
    });

    // if(Supabase.instance.client.auth.session() != null){
    //   WidgetsBinding.instance!.addPostFrameCallback((_) {
    //     Get.offAllNamed(Routes.main, predicate: (_) => false);
    //   });
    // }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: ExtendedImage.asset(
              'assets/images/cosmos_line.jpg',
              color: Colors.black26,
              colorBlendMode: BlendMode.darken,
              fit: BoxFit.cover,
            ),
          ),
          // Positioned(
          //   bottom: 50.0,
          //   child: MaterialButton(
          //     color: Style.gold,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(50),
          //     ),
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 32,
          //     ),
          //     onPressed: () => Get.toNamed(RouteName.login),
          //     child: const AText(
          //       '开始漫游',
          //       fontSize: 16,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

