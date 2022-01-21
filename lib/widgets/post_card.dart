import 'package:cosmonaut/core/styles.dart';
import 'package:cosmonaut/data/api.dart';
import 'package:cosmonaut/data/model.dart';
import 'package:cosmonaut/data/provider.dart';
import 'package:cosmonaut/extension.dart';
import 'package:cosmonaut/utils/time.dart';
import 'package:cosmonaut/widgets/a_text.dart';
import 'package:cosmonaut/widgets/gap.dart';
import 'package:cosmonaut/widgets/shimmer_rect.dart';
import 'package:cosmonaut/widgets/shimmer_wrapper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:line_icons/line_icons.dart';

class PostCard extends StatefulWidget {
  final PostModel? post;
  final void Function()? onTap;

  const PostCard({Key? key, required this.post, this.onTap}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool liked;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    liked = post?.liked ?? false;
    final profile = context.watch<ProfileNotifier>().profile;
    final shouldShimmer = post == null;
    final isMe = post != null && profile?.uid == post.uid;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
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
                ShimmerWrapper(
                  shouldShimmer: shouldShimmer,
                  shimmer: Container(
                    width: 54,
                    height: 54,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                  child: ExtendedImage.network(
                    (isMe ? profile?.avatar : post?.avatar) ?? '',
                    cache: true,
                    width: 54,
                    height: 54,
                    fit: BoxFit.fill,
                    shape: BoxShape.circle,
                  ),
                ),
                const Gap(16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerWrapper(
                        shouldShimmer: shouldShimmer,
                        shimmer: const ShimmerRect(
                          width: 80,
                          height: 18,
                        ),
                        child: AText(
                          (isMe ? profile?.nickname : post?.nickname) ?? '',
                          fontSize: 18,
                        ),
                      ),
                      const Gap(8.0),
                      ShimmerWrapper(
                        shouldShimmer: shouldShimmer,
                        shimmer: const ShimmerRect(
                          width: 150,
                          height: 18,
                        ),
                        child: AText(
                          dateTimeFormat.format(DateTime.parse(
                            post?.createdAt ?? DateTime.now().toIso8601String(),
                          )),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.5,
                        ),
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
            ShimmerWrapper(
              shouldShimmer: shouldShimmer,
              shimmer: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerRect(width: 200, height: 20),
                  Gap(16.0),
                  ShimmerRect(width: 100, height: 20),
                ],
              ),
              child: AText(
                post?.content ?? '',
                fontSize: 18,
                height: 1.6,
              ),
            ),
            const Gap(8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(LineIcons.commentDots),
                ),
                LikeButton(
                  isLiked: liked,
                  onTap: (v) async {
                    if (shouldShimmer) return v;
                    await Api.post.like(post!.id!, !liked);
                    liked = !liked;
                    return !v;
                  },
                  likeBuilder: (like) {
                    if (like) {
                      return const Icon(Icons.favorite);
                    }
                    return const Icon(Icons.favorite_border);
                  },
                  likeCount: post?.likeCount,
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
      ),
    );
  }
}
