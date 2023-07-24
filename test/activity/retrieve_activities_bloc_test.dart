import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:taskmanager_frontend/activity/activity_repository.dart';
import 'package:taskmanager_frontend/activity/retrieve_activities_bloc/retrieve_activities_bloc.dart';
import 'package:taskmanager_frontend/models/activity/activity_model.dart';
import 'package:taskmanager_frontend/models/paginated/paginated_model.dart';
import 'package:taskmanager_frontend/network/dio_exception.dart';

// Mock the ActivityRepository
class MockActivityRepository extends Mock implements ActivityRepository {}

void main() {
  group('RetrieveActivitiesBloc', () {
    // Initialize the mock repository
    final MockActivityRepository mockActivityRepository =
        MockActivityRepository();

    // Create a sample list of ActivityModel for testing
    final List<ActivityModel> sampleActivities = [
      const ActivityModel(id: 1, title: 'Activity 1', desc: 'Description 1'),
      const ActivityModel(id: 2, title: 'Activity 2', desc: 'Description 2'),
    ];

    // Test the RetrieveUserActivities event
    blocTest<RetrieveActivitiesBloc, RetrieveActivitiesState>(
      'emits [RetrieveActivitiesLoading, RetrieveActivitiesSuccess] when RetrieveUserActivities event is added',
      build: () {
        // Stub the getActivities method in the mock repository to return the sampleActivities
        when(mockActivityRepository.getActivities()).thenAnswer((_) async =>
            PaginatedModel<ActivityModel>(results: sampleActivities));
        return RetrieveActivitiesBloc(
            activityRepository: mockActivityRepository);
      },
      act: (bloc) => bloc.add(const RetrieveUserActivities()),
      expect: () => [
        RetrieveActivitiesLoading(),
        RetrieveActivitiesSuccess(sampleActivities),
      ],
    );

    // Test handling of DioException when fetching activities
    blocTest<RetrieveActivitiesBloc, RetrieveActivitiesState>(
      'emits [RetrieveActivitiesLoading, RetrieveActivitiesError] when DioException occurs',
      build: () {
        // Stub the getActivities method in the mock repository to throw a DioException
        when(mockActivityRepository.getActivities()).thenThrow(DioException(
            requestOptions: RequestOptions(),
            response: Response(
                requestOptions: RequestOptions(),
                data: null,
                statusCode: 500)));
        return RetrieveActivitiesBloc(
            activityRepository: mockActivityRepository);
      },
      act: (bloc) => bloc.add(const RetrieveUserActivities()),
      expect: () => [
        RetrieveActivitiesLoading(),
        const RetrieveActivitiesError(
            'DioError [DioErrorType.response]: Http status error [500]'),
      ],
    );

    // Add more test cases as needed for other scenarios.
  });
}
