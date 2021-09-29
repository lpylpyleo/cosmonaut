import 'package:cosmonaut/core/styles.dart';
import 'package:cosmonaut/generated/l10n.dart';
import 'package:cosmonaut/widgets/a_app_bar.dart';
import 'package:cosmonaut/widgets/starry_sky.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class MainPage extends StatefulHookWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);

    return Scaffold(
      appBar: AAppBar(title: S.current.appName),
      body: TabBarView(
        controller: tabController,
        children: [
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return const FlutterLogo(
                size: 100,
              );
            },
          ),
          const StarrySky(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: currentIndex.value,
          onTap: (i) {
             currentIndex.value = i;
             tabController.index = i;
          },
          iconSize: 24,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: Style.gold,
          items: const [
            BottomNavigationBarItem(icon: Icon(LineIcons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(LineIcons.user), label: 'Me'),
          ],
        ),
      ),
    );
  }
}
