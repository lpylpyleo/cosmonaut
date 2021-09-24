import 'package:cosmonaut/generated/l10n.dart';
import 'package:cosmonaut/widgets/a_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AAppBar(title: S.current.appName),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return const FlutterLogo(size: 100,);
      },),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: currentIndex.value,
          onTap: (i) => currentIndex.value = i,
          iconSize: 24,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(icon: Icon(LineIcons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(LineIcons.user), label: 'Home'),
          ],
        ),
      ),
    );
  }
}
