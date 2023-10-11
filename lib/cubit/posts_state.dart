part of 'posts_cubit.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoaded extends PostsState {
  final List<Post> posts;

  PostsLoaded({required this.posts});
}

class PostsLoading extends PostsState {
  final List<Post> oldPosts;
  final bool isFirstFetch;

  PostsLoading({required this.oldPosts, this.isFirstFetch = false});
}
