import 'dart:convert';
import 'package:http/http.dart';
import 'post_model.dart';

class HttpService {
  Future<List<Post>> getPosts() async {
    Response res = await get(Uri.http('https://google.com.br', ''));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
