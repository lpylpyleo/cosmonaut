part of '../provider.dart';

class PostNotifier with ChangeNotifier {
  final List<PostModel> _posts = [];

  List<PostModel> get posts => _posts;

  void add(PostModel post) {
    _posts.add(post);
    notifyListeners();
  }

  Future<void> refreshPosts() async {
    final value = await Api.post.getAll();
    _posts.clear();
    _posts.addAll(value);
    notifyListeners();
  }

  Future<void> refreshOne(int postId) async {
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index < 0) return;
    final value = await Api.post.getOne(postId);
    _posts.replaceRange(index, index + 1, [value]);
    notifyListeners();
  }
}
