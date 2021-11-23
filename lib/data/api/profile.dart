part of '../api.dart';

class Profile{
  Future get() async {
    await HttpClient.instance.get('/api/v1/profile',print);
  }
}