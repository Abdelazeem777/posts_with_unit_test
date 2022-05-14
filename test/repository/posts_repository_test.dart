import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:posts_with_unit_test/datasources/remote_datasource.dart';
import 'package:posts_with_unit_test/models/post_model.dart';
import 'package:posts_with_unit_test/repository/posts_repository.dart';

import 'posts_repository_test.mocks.dart';

@GenerateMocks([RemoteDataSource])
void main() {
  late RemoteDataSource mockRemoteDataSource;
  late PostsRepository postsRepository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    postsRepository = PostsRepositoryImpl(mockRemoteDataSource);
  });

  test('GetPosts should return a list of posts without any exceptions',
      () async {
    //arrange
    final posts = List.generate(
        5,
        (index) => PostModel(
            id: index,
            userId: index,
            title: 'title $index',
            body: 'body $index'));

    when(mockRemoteDataSource.getPosts())
        .thenAnswer((_) => Future.value(posts));

    //act
    final result = await postsRepository.getPosts();

    //assert
    expect(result, posts);
  });
}
