import 'package:cosmonaut/data/model/post.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RpcService {
  RpcService._();

  static final _client = Supabase.instance.client;

  static Future<List<Post>> getAllPosts() async {
    final resp = await _client.rpc('get_latest_posts').execute();
    if (resp.error != null) throw resp.error!.message;
    return (resp.data as List).map((e) => Post.fromJson(e)).toList();
  }
}
