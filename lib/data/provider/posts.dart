part of '../provider.dart';


class PostNotifier with ChangeNotifier {
  final List<PostModel> _posts = [];

  List<PostModel> get posts => _posts;

  void add(PostModel post) {
    _posts.add(post);
    notifyListeners();
  }

  Future<void> refreshPosts() async{
    final value = await Api.post.get();
    _posts.clear();
    _posts.addAll(value);
    notifyListeners();
  }
}
