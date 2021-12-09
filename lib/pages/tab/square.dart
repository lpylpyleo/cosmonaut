import 'package:cosmonaut/data/provider.dart';
import 'package:cosmonaut/utils/time.dart';
import 'package:cosmonaut/widgets/a_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
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

    return Consumer<PostNotifier>(
      builder: (context, provider, child) {
        final posts = provider.posts;
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            final post = posts[index];
            return Card(
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ExtendedImage.network(
                          post.avatar ?? '',
                          width: 64,
                          shape: BoxShape.circle,
                        ),
                        const SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AText(
                              post.nickname ?? '',
                              fontSize: 18,
                            ),
                            const SizedBox(height: 8.0),
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
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    AText(post.content ?? '', fontSize: 20),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(LineIcons.comment),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(LineIcons.heart),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
