import 'package:flutter_cubit_pagination/data/models/post.dart';
import 'package:flutter_cubit_pagination/data/services/posts_services.dart';

class PostsRepository {
  final PostsServices postsServices;

  PostsRepository({required this.postsServices});

  Future<List<Post>> fetchPosts(int page) async {
    final posts = await postsServices.fetchPosts(page);
    return posts.map((e) => Post.fromJson(e)).toList();
  }
}
