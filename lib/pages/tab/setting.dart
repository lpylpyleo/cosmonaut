import 'package:cosmonaut/core/router.dart';
import 'package:cosmonaut/data/api.dart';
import 'package:cosmonaut/data/provider.dart';
import 'package:cosmonaut/utils/logger.dart';
import 'package:cosmonaut/widgets/a_dialog.dart';
import 'package:cosmonaut/widgets/a_text.dart';
import 'package:cosmonaut/widgets/gap.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
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
    return Consumer<ProfileNotifier>(builder: (BuildContext context, ProfileNotifier value, Widget? child) {
      final profile = value.profile;
      final mediaQuery = MediaQuery.of(context);

      return Column(
        children: [
          Container(
            color: Colors.grey[800],
            padding: mediaQuery.padding.copyWith(bottom: 0) + const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Listener(
                  behavior: HitTestBehavior.opaque,
                  onPointerDown: changeAvatar,
                  child: profile?.avatar?.isEmpty ?? true
                      ? const Icon(
                          LineIcons.userAstronaut,
                          size: 64,
                        )
                      : ExtendedImage.network(
                          profile!.avatar!,
                          width: 64,
                          height: 64,
                          fit: BoxFit.fill,
                          cache: true,
                          shape: BoxShape.circle,
                          // enableLoadState: false,
                        ),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AText(
                        profile?.nickname ?? '',
                        fontSize: 18,
                      ),
                      const Gap(8),
                      AText(
                        profile?.uid ?? '',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    goToNamed(Routes.editProfile);
                  },
                  icon: const Icon(
                    LineIcons.editAlt,
                    size: 24,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: CupertinoButton.filled(
                onPressed: () async {
                  await Api.auth.signOut();
                  await context.n.pushNamedAndRemoveUntil(Routes.login, (_) => false);
                },
                child: const AText(
                  'Logout',
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Future<void> changeAvatar(_) async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        await Api.profile.changeAvatar(file.path);
        final value = await Api.profile.get();
        context.read<ProfileNotifier>().set(value);
        showDialog(context: context, builder: (_) => const ADialog(title: '更换成功'));
      }
    } catch (e) {
      logger.severe(e);
      showDialog(context: context, builder: (_) => ADialog(title: '更换失败\n$e'));
    }
  }
}
