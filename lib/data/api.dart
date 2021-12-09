import 'package:cosmonaut/data/http/http_client.dart';
import 'package:cosmonaut/utils/http.dart';
import 'package:cosmonaut/data/model.dart';

part 'api/auth.dart';

part 'api/profile.dart';

part 'api/post.dart';

class Api {
  static final auth = Auth();
  static final profile = Profile();
  static final post = Post();
}
