import 'package:cosmonaut/core/router.dart';
import 'package:cosmonaut/data/api.dart';
import 'package:cosmonaut/data/provider.dart';
import 'package:cosmonaut/widgets/a_text.dart';
import 'package:cosmonaut/widgets/gap.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:cosmonaut/extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({Key? key}) : super(key: key);

  @override
  _SettingTabState createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Consumer<ProfileNotifier>(builder: (BuildContext context, ProfileNotifier value, Widget? child) {
      final profile = value.profile;
      return Padding(
        padding: mediaQuery.padding + const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async{
                    final file = await ImagePicker().pickImage(source: ImageSource.gallery);

                  },
                  child: profile?.avatar?.isEmpty ?? true
                      ? const Icon(
                          LineIcons.userAstronaut,
                          size: 64,
                        )
                      : ExtendedImage.network(
                        profile!.avatar!,
                        width: 64,
                        cache: true,
                        shape: BoxShape.circle,
                      ),
                ),
                const Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AText(
                      profile?.nickname ?? '',
                      fontSize: 18,
                    ),
                    const Gap(4),
                    AText(
                      profile?.nickname ?? '',
                      fontSize: 16,
                    ),
                  ],
                )
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                await Api.auth.signOut();
                await context.n.pushNamedAndRemoveUntil(Routes.login, (_) => false);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      );
    });
  }
}
