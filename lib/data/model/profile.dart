part of '../model.dart';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.id,
    this.uid,
    this.avatar,
    this.nickname,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? uid;
  String? avatar;
  String? nickname;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    uid: json["uid"],
    avatar: json["avatar"],
    nickname: json["nickname"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    deletedAt: json["deletedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "avatar": avatar,
    "nickname": nickname,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "deletedAt": deletedAt,
  };
}
