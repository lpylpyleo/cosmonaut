part of '../model.dart';

List<PostModel> postFromJson(String str) => List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postToJson(List<PostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
  PostModel({
    this.id,
    this.title,
    this.createdAt,
    this.content,
    this.poster,
    this.displayName,
    this.avatar,
    this.isPublic,
  });

  final int? id;
  final String? title;
  final String? createdAt;
  final String? content;
  final String? poster;
  final String? displayName;
  final String? avatar;
  final bool? isPublic;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json["id"],
    title: json["title"],
    createdAt: json["created_at"],
    content: json["content"],
    poster: json["poster"],
    displayName: json["display_name"],
    avatar: json["avatar"],
    isPublic: json["isPublic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "created_at": createdAt,
    "content": content,
    "poster": poster,
    "display_name": displayName,
    "avatar": avatar,
    "isPublic": isPublic,
  };
}
