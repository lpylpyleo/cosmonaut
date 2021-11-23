import 'package:cosmonaut/data/api.dart';
import 'package:flutter/material.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({Key? key}) : super(key: key);

  @override
  _SettingTabState createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: Api.auth.signOut,
        child: const Text('Logout'),
      ),
    );
  }
}
