part of '../api.dart';

class Profile{
  Future get() async {
    final res = await HttpClient.instance.get('/api/v1/profile');
    logger.fine(res.data);
  }
}