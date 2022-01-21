import 'package:cosmonaut/data/api.dart';
import 'package:cosmonaut/data/model.dart';
import 'package:cosmonaut/widgets/a_app_bar.dart';
import 'package:cosmonaut/widgets/a_text.dart';
import 'package:cosmonaut/widgets/post_card.dart';
import 'package:flutter/material.dart';

class PostDetailPage extends StatefulWidget {
  final int postId;

  const PostDetailPage({Key? key, required this.postId}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  PostModel? post;

  @override
  void initState() {
    super.initState();
    Api.post.getOne(widget.postId).then((value) => setState(() => post = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AAppBar(
        title: 'POST',
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PostCard(post: post),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: AText(
              'Comments',
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
