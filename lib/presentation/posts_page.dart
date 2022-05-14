import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_with_unit_test/bloc/cubit/posts_cubit.dart';
import 'package:posts_with_unit_test/core/services/network_service.dart';
import 'package:posts_with_unit_test/datasources/remote_datasource.dart';
import 'package:posts_with_unit_test/repository/posts_repository.dart';

import '../models/post_model.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit(
        PostsRepositoryImpl(
          RemoteDataSourceImpl(NetworkServiceImpl()),
        ),
      )..loadPosts(),
      child: Scaffold(body: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is PostsError) _showErrorDialog(context);
      },
      builder: (context, state) {
        if (state is PostsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostsLoaded) {
          return _buildPostsList(state);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildPostsList(PostsLoaded state) {
    return ListView.builder(
      itemCount: state.posts.length,
      itemBuilder: (_, index) {
        final post = state.posts[index];
        return _PostItem(post);
      },
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('An error occurred!'),
      ),
    );
  }
}

class _PostItem extends StatelessWidget {
  final PostModel _post;
  const _PostItem(this._post);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(_post.id.toString()),
      title: Text(_post.title),
      subtitle: Text(_post.body),
    );
  }
}
