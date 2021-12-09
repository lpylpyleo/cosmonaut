part of '../provider.dart';

class ProfileNotifier with ChangeNotifier {
  ProfileModel? _profile;

  ProfileModel? get profile => _profile;

  void set(ProfileModel? newProfile) {
    _profile = newProfile;
    notifyListeners();
  }
}
