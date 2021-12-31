part of '../model.dart';

List<PostModel> postModelFromJson(String str) =>
    List<PostModel>.from((json.decode(str) ?? []).map((x) => PostModel.fromJson(x)));

String postModelToJson(List<PostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
  PostModel({
    this.id,
    this.creator,
    this.title,
    this.content,
    this.isPublic,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.uid,
    this.avatar,
    this.nickname,
  });

  int? id;
  String? creator;
  String? title;
  String? content;
  bool? isPublic;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? uid;
  String? avatar;
  String? nickname;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        creator: json["creator"],
        title: json["title"],
        content: json["content"],
        isPublic: json["isPublic"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        deletedAt: json["deletedAt"],
        uid: json["uid"],
        avatar: json["avatar"],
        nickname: json["nickname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "creator": creator,
        "title": title,
        "content": content,
        "isPublic": isPublic,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "deletedAt": deletedAt,
        "uid": uid,
        "avatar": avatar,
        "nickname": nickname,
      };
}
