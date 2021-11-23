part of '../api.dart';

class Post {
  Future create(String content) async {
    return HttpClient.instance.post('/api/v1/post', HttpUtil.emptyResponse, data: {
      'content': content,
    });
  }

  Future<List<model.PostModel>> get() async {
    final res = await HttpClient.instance.get(
      '/api/v1/post',
      (v) => (v as List?)?.map((e) => model.PostModel.fromJson(e)).toList() ?? [],
    );
    return res;
  }
}
