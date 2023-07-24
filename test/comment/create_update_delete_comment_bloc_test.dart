import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:taskmanager_frontend/comment/comment_repository.dart';
import 'package:taskmanager_frontend/comment/create_update_delete_bloc/create_update_delete_comment_bloc.dart';
import 'package:taskmanager_frontend/models/comment/comment_model.dart';

// Mock the ActivityRepository
class MockCommentRepository extends Mock implements CommentRepository {}

void main() {
  group('CreateUpdateDeleteCommentBloc', () {
    // Initialize the mock repository
    final MockCommentRepository mockCommentRepository =
    MockCommentRepository();

    // Create a sample ActivityModel for testing
    const sampleComment = CommentModel(
        id: 1, content: 'Sample Content');

    test(
        'emits [CreateUpdateDeleteCommentLoading, CreateUpdateDeleteCommentSuccess] '
            'when CreateComment event is added with successful comment creation',
            () async {
          // Stub the createActivity method in the mock repository to return the sampleActivity
          when(mockCommentRepository.createComment(any))
              .thenAnswer((_) async => sampleComment);

          final bloc = CreateUpdateDeleteCommentBloc(
              commentRepository: mockCommentRepository);

          expectLater(
            bloc.stream,
            emitsInOrder([
              CreateUpdateDeleteCommentLoading(),
              const CreateUpdateDeleteCommentSuccess(sampleComment),
            ]),
          );

          bloc.add(const CreateComment(sampleComment));
        });

    test(
        'emits [CreateUpdateDeleteCommentLoading, CreateUpdateDeleteCommentSuccess] '
            'when UpdateComment event is added with successful comment update',
            () async {
          // Stub the updateActivity method in the mock repository to return the sampleActivity
          when(mockCommentRepository.updateComment(any))
              .thenAnswer((_) async => sampleComment);

          final bloc = CreateUpdateDeleteCommentBloc(
              commentRepository: mockCommentRepository);

          expectLater(
            bloc.stream,
            emitsInOrder([
              CreateUpdateDeleteCommentLoading(),
              const CreateUpdateDeleteCommentSuccess(sampleComment),
            ]),
          );

          bloc.add(const UpdateComment(sampleComment));
        });

    test(
        'emits [CreateUpdateDeleteCommentLoading, CreateUpdateDeleteCommentSuccess] '
            'when DeleteComment event is added with successful comment deletion',
            () async {
          // Stub the deleteActivity method in the mock repository to return the sampleActivity
          when(mockCommentRepository.deleteComment(any))
              .thenAnswer((_) async => sampleComment);

          final bloc = CreateUpdateDeleteCommentBloc(
              commentRepository: mockCommentRepository);

          expectLater(
            bloc.stream,
            emitsInOrder([
              CreateUpdateDeleteCommentLoading(),
              const CreateUpdateDeleteCommentSuccess(sampleComment),
            ]),
          );

          bloc.add(const DeleteComment(sampleComment));
        });

    test(
        'emits [CreateUpdateDeleteCommentLoading, CreateUpdateDeleteCommentSuccess] '
            'when RetrieveIndividualComment event is added with successful comment retrieval',
            () async {
          // Stub the retrieveSpecificActivity method in the mock repository to return the sampleActivity
          when(mockCommentRepository.retrieveSpecificComment(any))
              .thenAnswer((_) async => sampleComment);

          final bloc = CreateUpdateDeleteCommentBloc(
              commentRepository: mockCommentRepository);

          expectLater(
            bloc.stream,
            emitsInOrder([
              CreateUpdateDeleteCommentLoading(),
              const CreateUpdateDeleteCommentSuccess(sampleComment),
            ]),
          );

          bloc.add(const RetrieveIndividualComment(1));
        });

    // Add more test cases as needed for other scenarios.

    // Close the bloc after testing
  });
}
