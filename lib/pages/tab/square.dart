import 'package:cosmonaut/core/constants.dart';
import 'package:cosmonaut/core/router.dart';
import 'package:cosmonaut/data/provider.dart';
import 'package:cosmonaut/extension.dart';
import 'package:cosmonaut/generated/l10n.dart';
import 'package:cosmonaut/widgets/a_app_bar.dart';
import 'package:cosmonaut/widgets/post_card.dart';
import 'package:flutter/material.dart';

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
              return PostCard(
                key: ValueKey(post.id),
                post: post,
                onTap: () => goToDetail(post.id!),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> goToDetail(int postId) async {
    if (ModalRoute.of(C.context)?.settings.name == Routes.postDetail) return;
    await goToNamed(Routes.postDetail, args: {'postId': postId});
    context.read<PostNotifier>().refreshOne(postId);
  }

  @override
  bool get wantKeepAlive => true;
}
