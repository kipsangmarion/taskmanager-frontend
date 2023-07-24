import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:taskmanager_frontend/activity/activity_repository.dart';
import 'package:taskmanager_frontend/activity/create_update_delete_bloc/create_update_delete_activity_bloc.dart';
import 'package:taskmanager_frontend/models/activity/activity_model.dart';

// Mock the ActivityRepository
class MockActivityRepository extends Mock implements ActivityRepository {}

void main() {
  group('CreateUpdateDeleteActivityBloc', () {
    // Initialize the mock repository
    final MockActivityRepository mockActivityRepository =
        MockActivityRepository();

    // Create a sample ActivityModel for testing
    const sampleActivity = ActivityModel(
        id: 1, title: 'Sample Activity', desc: 'Sample Description');

    test(
        'emits [CreateUpdateDeleteActivityLoading, CreateUpdateDeleteActivitySuccess] '
        'when CreateActivity event is added with successful activity creation',
        () async {
      // Stub the createActivity method in the mock repository to return the sampleActivity
      when(mockActivityRepository.createActivity(any))
          .thenAnswer((_) async => sampleActivity);

      final bloc = CreateUpdateDeleteActivityBloc(
          activityRepository: mockActivityRepository);

      expectLater(
        bloc.stream,
        emitsInOrder([
          CreateUpdateDeleteActivityLoading(),
          const CreateUpdateDeleteActivitySuccess(sampleActivity),
        ]),
      );

      bloc.add(const CreateActivity(sampleActivity));
    });

    test(
        'emits [CreateUpdateDeleteActivityLoading, CreateUpdateDeleteActivitySuccess] '
        'when UpdateActivity event is added with successful activity update',
        () async {
      // Stub the updateActivity method in the mock repository to return the sampleActivity
      when(mockActivityRepository.updateActivity(any))
          .thenAnswer((_) async => sampleActivity);

      final bloc = CreateUpdateDeleteActivityBloc(
          activityRepository: mockActivityRepository);

      expectLater(
        bloc.stream,
        emitsInOrder([
          CreateUpdateDeleteActivityLoading(),
          const CreateUpdateDeleteActivitySuccess(sampleActivity),
        ]),
      );

      bloc.add(const UpdateActivity(sampleActivity));
    });

    test(
        'emits [CreateUpdateDeleteActivityLoading, CreateUpdateDeleteActivitySuccess] '
        'when DeleteActivity event is added with successful activity deletion',
        () async {
      // Stub the deleteActivity method in the mock repository to return the sampleActivity
      when(mockActivityRepository.deleteActivity(any))
          .thenAnswer((_) async => sampleActivity);

      final bloc = CreateUpdateDeleteActivityBloc(
          activityRepository: mockActivityRepository);

      expectLater(
        bloc.stream,
        emitsInOrder([
          CreateUpdateDeleteActivityLoading(),
          const CreateUpdateDeleteActivitySuccess(sampleActivity),
        ]),
      );

      bloc.add(const DeleteActivity(sampleActivity));
    });

    test(
        'emits [CreateUpdateDeleteActivityLoading, CreateUpdateDeleteActivitySuccess] '
        'when RetrieveIndividualActivity event is added with successful activity retrieval',
        () async {
      // Stub the retrieveSpecificActivity method in the mock repository to return the sampleActivity
      when(mockActivityRepository.retrieveSpecificActivity(any))
          .thenAnswer((_) async => sampleActivity);

      final bloc = CreateUpdateDeleteActivityBloc(
          activityRepository: mockActivityRepository);

      expectLater(
        bloc.stream,
        emitsInOrder([
          CreateUpdateDeleteActivityLoading(),
          const CreateUpdateDeleteActivitySuccess(sampleActivity),
        ]),
      );

      bloc.add(const RetrieveIndividualActivity(1));
    });

    // Add more test cases as needed for other scenarios.

    // Close the bloc after testing
  });
}
