import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:posts_with_unit_test/repository/posts_repository.dart';

import '../../models/post_model.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepository _postsRepository;
  PostsCubit(this._postsRepository) : super(PostsInitial());

  Future<void> loadPosts() async {
    emit(const PostsLoading());
    try {
      final posts = await _postsRepository.getPosts();
      emit(PostsLoaded(posts));
    } on Exception catch (e) {
      var string = e.toString();
      emit(const PostsError());
    }
  }
}
