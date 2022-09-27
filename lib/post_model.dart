// @dart=2.9

import 'package:flutter/foundation.dart';

class Post {
  final int userId;
  // final int id;
  // final String title;
  // final String body;

  Post(this.userId);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(0);
  }
}
