part of '../api.dart';

class Post {
  Future create(String content, {bool isPublic = true}) async {
    return HttpClient.instance.post('/api/v1/post', HttpUtil.emptyResponse, data: {
      'content': content,
      'isPublic': isPublic,
    });
  }

  Future<List<PostModel>> get() async {
    return HttpClient.instance.get(
      '/api/v1/post',
      (v) => (v as List?)?.map((e) => PostModel.fromJson(e)).toList() ?? [],
    );
  }
}
