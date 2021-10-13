import 'package:cosmonaut/core/router.dart';
import 'package:cosmonaut/core/styles.dart';
import 'package:cosmonaut/generated/l10n.dart';
import 'package:cosmonaut/pages/tab/square.dart';
import 'package:cosmonaut/utils/navigation.dart';
import 'package:cosmonaut/widgets/a_app_bar.dart';
import 'package:cosmonaut/widgets/starry_sky.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(title: S.current.appName),
      body: TabBarView(
        controller: tabController,
        children: const [
          SquareTab(),
          StarrySky(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => goToNamed(Routes.createPost),
        child: const RotatedBox(
          quarterTurns: 0,
          child: Icon(LineIcons.telegramPlane),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 4,
        shape: const CircularNotchedRectangle(),
        color: Colors.grey[800],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: tabs
              .map((e) => IconButton(
                    onPressed: e.onTap,
                    icon: Icon(e.icon),
                    iconSize: 36.0,
                    color: currentIndex.value == e.index ? Style.gold : null,
                  ))
              .toList(),
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
