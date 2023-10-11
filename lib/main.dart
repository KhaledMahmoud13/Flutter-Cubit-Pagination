import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_pagination/cubit/posts_cubit.dart';
import 'package:flutter_cubit_pagination/data/repository/posts_repository.dart';
import 'package:flutter_cubit_pagination/data/services/posts_services.dart';
import 'package:flutter_cubit_pagination/presentation/posts_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => PostsCubit(
          postsRepository: PostsRepository(
            postsServices: PostsServices(),
          ),
        ),
        child: PostsScreen(),
      ),
    );
  }
}
