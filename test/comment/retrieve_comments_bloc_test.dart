import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:taskmanager_frontend/comment/comment_repository.dart';
import 'package:taskmanager_frontend/comment/retrieve_comments/retrieve_comments_bloc.dart';
import 'package:taskmanager_frontend/models/comment/comment_model.dart';
import 'package:taskmanager_frontend/models/paginated/paginated_model.dart';
import 'package:taskmanager_frontend/network/dio_exception.dart';

// Mock the ActivityRepository
class MockCommentRepository extends Mock implements CommentRepository {}

void main() {
  group('RetrieveCommentsBloc', () {
    // Initialize the mock repository
    final MockCommentRepository mockCommentRepository =
    MockCommentRepository();

    // Create a sample list of ActivityModel for testing
    final List<CommentModel> sampleComments = [
      const CommentModel(id: 1, content: 'Description 1'),
      const CommentModel(id: 2, content: 'Description 2'),
    ];

    // Test the RetrieveUserActivities event
    blocTest<RetrieveCommentsBloc, RetrieveCommentsState>(
      'emits [RetrieveCommentsLoading, RetrieveCommentsSuccess] when RetrieveUserComments event is added',
      build: () {
        // Stub the getActivities method in the mock repository to return the sampleActivities
        when(mockCommentRepository.getComments()).thenAnswer((_) async =>
            PaginatedModel<CommentModel>(results: sampleComments));
        return RetrieveCommentsBloc(
            commentRepository: mockCommentRepository);
      },
      act: (bloc) => bloc.add(const RetrieveUserComments()),
      expect: () => [
        RetrieveCommentsLoading(),
        RetrieveCommentsSuccess(sampleComments),
      ],
    );

    // Test handling of DioException when fetching activities
    blocTest<RetrieveCommentsBloc, RetrieveCommentsState>(
      'emits [RetrieveActivitiesLoading, RetrieveActivitiesError] when DioException occurs',
      build: () {
        // Stub the getActivities method in the mock repository to throw a DioException
        when(mockCommentRepository.getComments()).thenThrow(DioException(
            requestOptions: RequestOptions(),
            response: Response(
                requestOptions: RequestOptions(),
                data: null,
                statusCode: 500)));
        return RetrieveCommentsBloc(
            commentRepository: mockCommentRepository);
      },
      act: (bloc) => bloc.add(const RetrieveUserComments()),
      expect: () => [
        RetrieveCommentsLoading(),
        const RetrieveCommentsError(
            'DioError [DioErrorType.response]: Http status error [500]'),
      ],
    );

    // Add more test cases as needed for other scenarios.
  });
}