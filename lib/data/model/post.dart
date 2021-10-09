import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    this.id,
    this.title,
    this.createdAt,
    this.content,
    this.poster,
    this.displayName,
    this.avatar,
  });

  final int? id;
  final String? title;
  final String? createdAt;
  final String? content;
  final String? poster;
  final String? displayName;
  final String? avatar;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    title: json["title"],
    createdAt: json["created_at"],
    content: json["content"],
    poster: json["poster"],
    displayName: json["display_name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "created_at": createdAt,
    "content": content,
    "poster": poster,
    "display_name": displayName,
    "avatar": avatar,
  };
}
