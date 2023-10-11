import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_pagination/cubit/posts_cubit.dart';
import 'package:flutter_cubit_pagination/data/models/post.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({super.key});

  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(
      () {
        if (scrollController.position.atEdge) {
          if (scrollController.position.pixels != 0) {
            BlocProvider.of<PostsCubit>(context).loadPosts();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<PostsCubit>(context).loadPosts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          if (state is PostsLoading && state.isFirstFetch) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          List<Post> posts = [];
          bool isLoading = false;

          if (state is PostsLoading) {
            posts = state.oldPosts;
            isLoading = true;
          } else if (state is PostsLoaded) {
            posts = state.posts;
          }

          return ListView.builder(
            controller: scrollController,
            itemCount: posts.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < posts.length) {
                return Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${posts[index].id}. ${posts[index].title}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(posts[index].body),
                      ],
                    ),
                  ),
                );
              } else {
                if (isLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }
            },
          );
        },
      ),
    );
  }
}
