part of '../api.dart';

class Post {
  Future create(String content) async {
    return HttpClient.instance.post('/api/v1/post', data: {
      'content': content,
    });
  }

  Future get() async {
    return HttpClient.instance.get('/api/v1/post');
  }
}
