import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_pagination/data/models/post.dart';
import 'package:flutter_cubit_pagination/data/repository/posts_repository.dart';
import 'package:meta/meta.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit({required this.postsRepository}) : super(PostsInitial());

  int page = 1;
  final PostsRepository postsRepository;

  void loadPosts() {
    if (state is PostsLoading) return;

    final currentState = state;

    List<Post> oldPosts = [];
    if (currentState is PostsLoaded) {
      oldPosts = currentState.posts;
    }

    emit(PostsLoading(oldPosts: oldPosts, isFirstFetch: page == 1));

    postsRepository.fetchPosts(page).then((newPosts) {
      page++;

      final posts = List<Post>.from(oldPosts);
      posts.addAll(newPosts);

      emit(PostsLoaded(posts: posts));
    });
  }
}
