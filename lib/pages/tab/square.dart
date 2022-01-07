import 'package:cosmonaut/core/styles.dart';
import 'package:cosmonaut/data/api.dart';
import 'package:cosmonaut/data/model.dart';
import 'package:cosmonaut/data/provider.dart';
import 'package:cosmonaut/generated/l10n.dart';
import 'package:cosmonaut/utils/time.dart';
import 'package:cosmonaut/widgets/a_app_bar.dart';
import 'package:cosmonaut/widgets/a_text.dart';
import 'package:cosmonaut/widgets/gap.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:line_icons/line_icons.dart';
import 'package:cosmonaut/extension.dart';

class SquareTab extends StatefulWidget {
  const SquareTab({Key? key}) : super(key: key);

  @override
  _SquareTabState createState() => _SquareTabState();
}

class _SquareTabState extends State<SquareTab> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<PostNotifier>().refreshPosts();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const sep = SizedBox(height: 16);

    return Scaffold(
      appBar: AAppBar(title: S.current.appName),
      extendBodyBehindAppBar: true,
      body: Consumer<PostNotifier>(
        builder: (context, provider, child) {
          final mediaQuery = MediaQuery.of(context);
          final posts = provider.posts;
          return ListView.separated(
            primary: true,
            padding: mediaQuery.padding + const EdgeInsets.all(16.0),
            itemCount: posts.length,
            separatorBuilder: (_, __) => sep,
            itemBuilder: (BuildContext context, int index) {
              final post = posts[index];
              return _PostItem(
                key: ValueKey(post.id),
                post: post,
              );
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _PostItem extends StatefulWidget {
  final PostModel post;

  const _PostItem({Key? key, required this.post}) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<_PostItem> {
  late bool liked;

  @override
  void initState() {
    super.initState();
    liked = widget.post.liked ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final profile = context.watch<ProfileNotifier>().profile;
    final isMe = profile?.uid == post.uid;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: AppBorderRadius.medium,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ExtendedImage.network(
                (isMe ? profile?.avatar : post.avatar) ?? '',
                cache: true,
                width: 54,
                height: 54,
                fit: BoxFit.fill,
                shape: BoxShape.circle,
              ),
              const Gap(16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AText(
                      (isMe ? profile?.nickname : post.nickname) ?? '',
                      fontSize: 18,
                    ),
                    const Gap(8.0),
                    AText(
                      dateTimeFormat.format(DateTime.parse(
                        post.createdAt ?? DateTime.now().toIso8601String(),
                      )),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.5,
                    ),
                  ],
                ),
              ),
              const Gap(16.0),
              IconButton(
                onPressed: () {},
                icon: const Icon(LineIcons.horizontalEllipsis),
              ),
            ],
          ),
          const Gap(16.0),
          AText(
            post.content ?? '',
            fontSize: 18,
            height: 1.6,
          ),
          const Gap(8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(LineIcons.commentDots),
              ),
              LikeButton(
                isLiked: liked,
                onTap: (v) async {
                  await Api.post.like(post.id!, !liked);
                  liked = !liked;
                  return !v;
                },
                likeBuilder: (like) {
                  if (like) {
                    return const Icon(Icons.favorite);
                  }
                  return const Icon(Icons.favorite_border);
                },
                likeCount: post.likeCount,
                countBuilder: (count, liked, text) {
                  return AText(
                    text,
                    fontSize: 16,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
