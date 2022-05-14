import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts_with_unit_test/bloc/cubit/posts_cubit.dart';
import 'package:posts_with_unit_test/models/post_model.dart';
import 'package:posts_with_unit_test/repository/posts_repository.dart';

import 'posts_cubit_test.mocks.dart';

@GenerateMocks([PostsRepository])
void main() {
  late PostsCubit postsCubit;
  late PostsRepository mockPostsRepository;

  setUp(() {
    mockPostsRepository = MockPostsRepository();
    postsCubit = PostsCubit(mockPostsRepository);
  });

  test(
      'PostsCubit should emit PostsLoading then PostsLoaded State with a list of posts when calling loadPosts method',
      () async {
    //arrange
    final posts = List.generate(
        5,
        (index) => PostModel(
            id: index,
            userId: index,
            title: 'title $index',
            body: 'body $index'));
    when(mockPostsRepository.getPosts()).thenAnswer((_) => Future.value(posts));

    //assert
    final expectedStates = [
      const PostsLoading(),
      PostsLoaded(posts),
    ];

    expectLater(postsCubit.stream, emitsInAnyOrder(expectedStates));

    //act
    postsCubit.loadPosts();
  });

  test(
    '''PostsCubit should emit PostsLoading then PostsError State
   when calling loadPosts method if repository throw an Exception''',
    () {
      //arrange
      when(mockPostsRepository.getPosts())
          .thenAnswer((_) async => throw Exception());

      //assert
      final expectedStates = [
        const PostsLoading(),
        const PostsError(),
      ];

      expectLater(postsCubit.stream, emitsInAnyOrder(expectedStates));

      //act
      postsCubit.loadPosts();
    },
  );
}
