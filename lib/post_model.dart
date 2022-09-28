import 'package:flutter/foundation.dart';

class Post {
  final int userId;

  Post(this.userId);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(0);
  }
}
