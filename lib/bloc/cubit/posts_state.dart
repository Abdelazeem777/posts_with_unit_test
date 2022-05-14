part of 'posts_cubit.dart';

@immutable
abstract class PostsState {
  const PostsState();
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {
  const PostsLoading();
}

class PostsLoaded extends PostsState {
  final List<PostModel> posts;

  const PostsLoaded(this.posts);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostsLoaded && listEquals(other.posts, posts);
  }

  @override
  int get hashCode => posts.hashCode;
}

class PostsError extends PostsState {
  final String? message;
  const PostsError({this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostsError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
