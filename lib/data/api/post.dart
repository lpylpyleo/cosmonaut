part of '../api.dart';

class Post {
  Future<bool> create(String content, {bool isPublic = true}) async {
    return HttpClient.instance.post(
      '/api/v1/post',
      HttpUtil.emptyResponse,
      data: {
        'content': content,
        'isPublic': isPublic,
      },
    );
  }

  Future<List<PostModel>> get() async {
    return HttpClient.instance.get(
      '/api/v1/post',
      (v) => postModelFromJson(v),
    );
  }

  Future<bool> like(int pid, bool isLike) async {
    return HttpClient.instance.post(
      '/api/v1/post/like',
      HttpUtil.emptyResponse,
      data: {
        'pid': pid,
        'isLike': isLike,
      },
    );
  }
}
