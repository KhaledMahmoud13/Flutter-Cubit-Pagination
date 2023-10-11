import 'dart:convert';

import 'package:http/http.dart' as http;

class PostsServices {
  static const FETCH_LIMIT = 20;
  final baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List> fetchPosts(int page) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl?_limit=$FETCH_LIMIT&_page=$page'));
      return jsonDecode(response.body) as List<dynamic>;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
