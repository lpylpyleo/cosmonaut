part of '../api.dart';

class Profile {
  Future<ProfileModel> get() async {
    return HttpClient.instance.get('/api/v1/profile', (v) => profileModelFromJson(v));
  }

  Future<bool> changeAvatar(String path) async {
    return HttpClient.instance.upload(
      '/api/v1/profile/changeAvatar',
      HttpUtil.emptyResponse,
      'avatar',
      path,
    );
  }

  Future<bool> editProfile({String? nickname, String? motto}) async {
    return HttpClient.instance.post(
      '/api/v1/profile/edit',
      HttpUtil.emptyResponse,
      data: {
        'nickname': nickname,
        'motto': motto,
      },
    );
  }
}
