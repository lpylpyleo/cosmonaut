part of '../api.dart';

class Profile {
  Future<ProfileModel> get() async {
    return HttpClient.instance.get('/api/v1/profile', (v) => profileModelFromJson(v));
  }
}
