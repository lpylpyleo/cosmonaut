import 'dart:ui';

import 'package:cosmonaut/core/router.dart';
import 'package:cosmonaut/core/styles.dart';
import 'package:cosmonaut/data/api.dart';
import 'package:cosmonaut/data/provider.dart';
import 'package:cosmonaut/extension.dart';
import 'package:cosmonaut/generated/l10n.dart';
import 'package:cosmonaut/pages/tab/setting.dart';
import 'package:cosmonaut/pages/tab/square.dart';
import 'package:cosmonaut/utils/navigation.dart';
import 'package:cosmonaut/widgets/a_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:line_icons/line_icons.dart';

class MainPage extends StatefulHookWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  final currentIndex = ValueNotifier(0);
  late final TabController tabController;

  late final List<_TabConfig> tabs;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        currentIndex.value = tabController.index;
      });
    tabs = [
      _TabConfig(
        0,
        LineIcons.squareWave,
        () {
          currentIndex.value = 0;
          tabController.index = 0;
        },
      ),
      _TabConfig(
        1,
        LineIcons.userAstronaut,
        () {
          currentIndex.value = 1;
          tabController.index = 1;
        },
      ),
    ];

    Api.profile.get().then((value) => context.read<ProfileNotifier>().set(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(title: S.current.appName),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: TabBarView(
        controller: tabController,
        children: const [
          SquareTab(),
          SettingTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => goToNamed(Routes.createPost).then((_) => context.read<PostNotifier>().refreshPosts()),
        child: const RotatedBox(
          quarterTurns: 0,
          child: Icon(LineIcons.telegramPlane),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: BottomAppBar(
            elevation: 0,
            shape: const CircularNotchedRectangle(),
            color: Colors.grey[800]!.withOpacity(0.5),
            child: ValueListenableBuilder(
              valueListenable: currentIndex,
              builder: (BuildContext context, int value, Widget? child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: tabs
                      .map(
                        (e) => GestureDetector(
                          onTap: e.onTap,
                          child: Container(
                            width: 54,
                            height: 54,
                            alignment: Alignment.center,
                            child: Icon(
                              e.icon,
                              size: 36,
                              color: value == e.index ? AppPalette.gold : Colors.grey,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _TabConfig {
  final int index;
  final IconData icon;
  final VoidCallback onTap;

  const _TabConfig(this.index, this.icon, this.onTap);
}
