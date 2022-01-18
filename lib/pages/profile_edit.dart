import 'package:cosmonaut/core/router.dart';
import 'package:cosmonaut/core/styles.dart';
import 'package:cosmonaut/data/api.dart';
import 'package:cosmonaut/data/provider.dart';
import 'package:cosmonaut/utils/logger.dart';
import 'package:cosmonaut/widgets/a_app_bar.dart';
import 'package:cosmonaut/widgets/a_dialog.dart';
import 'package:cosmonaut/widgets/a_text.dart';
import 'package:cosmonaut/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cosmonaut/extension.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  String nickname = '';
  String motto = '';

  @override
  Widget build(BuildContext context) {
    const deco = InputDecoration(
      isDense: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppPalette.gold),
        borderRadius: AppBorderRadius.medium,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppPalette.gold),
        borderRadius: AppBorderRadius.medium,
      ),
    );

    return Scaffold(
      appBar: const AAppBar(
        title: 'Edit',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AText(
              'Nickname',
              fontSize: 16,
            ),
            const Gap(8),
            TextField(
              decoration: deco,
              onChanged: (v) => nickname = v,
            ),
            const Gap(16),
            const AText(
              'Motto',
              fontSize: 16,
            ),
            const Gap(8),
            TextField(
              onChanged: (v) => motto = v,
              minLines: 5,
              maxLines: 5,
              decoration: deco,
            ),
            const Gap(32),
            Center(
              child: CupertinoButton.filled(
                child: const AText(
                  'submit',
                  color: Colors.black,
                ),
                onPressed: edit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> edit() async {
    try {
      await Api.profile.editProfile(nickname: nickname, motto: motto);
      final p = await Api.profile.get();
      context.read<ProfileNotifier>().set(p);
      await showDialog(context: context, builder: (_) => const ADialog(title: 'Edit Success'));
      goBack();
    } catch (e) {
      logger.severe(e);
      showDialog(context: context, builder: (_) => const ADialog(title: 'Edit Failed'));
    }
  }
}
