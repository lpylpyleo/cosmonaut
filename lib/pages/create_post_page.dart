import 'package:cosmonaut/core/router.dart';
import 'package:cosmonaut/core/styles.dart';
import 'package:cosmonaut/data/api.dart';
import 'package:cosmonaut/generated/l10n.dart';
import 'package:cosmonaut/widgets/a_app_bar.dart';
import 'package:cosmonaut/widgets/a_dialog.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final content = ValueNotifier('');

  final tools = [
    _Tool(LineIcons.hashtag, () {}),
    _Tool(LineIcons.music, () {}),
    _Tool(LineIcons.photoVideo, () {}),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        title: S.current.create_post,
        leading: const BackButton(),
        trailing: MaterialButton(
          color: AppPalette.gold,
          onPressed: () async {
            if (content.value.isEmpty) {
              return showDialog(
                context: context,
                builder: (BuildContext context) => const ADialog(title: 'Empty'),
              );
            }
            await Api.post.create(content.value);
            goBack();
          },
          child: const Icon(
            LineIcons.telegramPlane,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              child: TextField(
                autofocus: true,
                onChanged: (v) => content.value = v,
                minLines: 5,
                maxLines: null,
                maxLength: 1000,
                style: const TextStyle(
                  letterSpacing: 1,
                ),
                cursorColor: AppPalette.gold,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppPalette.gold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.grey[700],
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: SafeArea(
              child: Row(
                children: tools
                    .map(
                      (e) => IconButton(
                        onPressed: e.onTap,
                        icon: Icon(e.icon),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Tool {
  final IconData icon;
  final VoidCallback onTap;

  const _Tool(this.icon, this.onTap);
}
