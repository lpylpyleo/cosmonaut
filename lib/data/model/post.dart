part of '../model.dart';

List<PostModel> postModelListFromJson(String str) =>
    List<PostModel>.from((json.decode(str) ?? []).map((x) => PostModel.fromJson(x)));

PostModel postModelFromJson(String str) => PostModel.fromJson((json.decode(str)));

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
    this.commentCount,
    this.likeCount,
    this.liked,
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
  int? commentCount;
  int? likeCount;
  bool? liked;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'],
        creator: json['creator'],
        title: json['title'],
        content: json['content'],
        isPublic: json['is_public'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        deletedAt: json['deleted_at'],
        uid: json['uid'],
        avatar: json['avatar'],
        nickname: json['nickname'],
        commentCount: json['comment_count'],
        likeCount: json['like_count'],
        liked: json['liked'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'creator': creator,
        'title': title,
        'content': content,
        'isPublic': isPublic,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
        'uid': uid,
        'avatar': avatar,
        'nickname': nickname,
        'commentCount': commentCount,
        'likeCount': likeCount,
        'liked': liked,
      };
}
