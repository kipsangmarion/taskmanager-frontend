import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:taskmanager_frontend/task/task_repository.dart';
import 'package:taskmanager_frontend/task/retrieve_tasks_bloc/retrieve_tasks_bloc.dart';
import 'package:taskmanager_frontend/models/task/task_model.dart';
import 'package:taskmanager_frontend/models/paginated/paginated_model.dart';
import 'package:taskmanager_frontend/network/dio_exception.dart';

// Mock the ActivityRepository
class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  group('RetrieveTasksBloc', () {
    // Initialize the mock repository
    final MockTaskRepository mockTaskRepository =
    MockTaskRepository();

    // Create a sample list of ActivityModel for testing
    final List<TaskModel> sampleTasks = [
      const TaskModel(id: 1, title: 'Task 1', desc: 'Description 1'),
      const TaskModel(id: 2, title: 'Task 2', desc: 'Description 2'),
    ];

    // Test the RetrieveUserActivities event
    blocTest<RetrieveTasksBloc, RetrieveTasksState>(
      'emits [RetrieveTasksLoading, RetrieveTasksSuccess] when RetrieveUserTasks event is added',
      build: () {
        // Stub the getActivities method in the mock repository to return the sampleActivities
        String? tag;
        when(mockTaskRepository.getTasks(tag)).thenAnswer((_) async =>
            PaginatedModel<TaskModel>(results: sampleTasks));
        return RetrieveTasksBloc(
            taskRepository: mockTaskRepository);
      },
      act: (bloc) => bloc.add(const RetrieveUserTasks()),
      expect: () => [
        RetrieveTasksLoading(),
        RetrieveTasksSuccess(sampleTasks),
      ],
    );

    // Test handling of DioException when fetching activities
    blocTest<RetrieveTasksBloc, RetrieveTasksState>(
      'emits [RetrieveTasksLoading, RetrieveTasksError] when DioException occurs',
      build: () {
        // Stub the getActivities method in the mock repository to throw a DioException
        String? tag;
        when(mockTaskRepository.getTasks(tag)).thenThrow(DioException(
            requestOptions: RequestOptions(),
            response: Response(
                requestOptions: RequestOptions(),
                data: null,
                statusCode: 500)));
        return RetrieveTasksBloc(
            taskRepository: mockTaskRepository);
      },
      act: (bloc) => bloc.add(const RetrieveUserTasks()),
      expect: () => [
        RetrieveTasksLoading(),
        const RetrieveTasksError(
            'DioError [DioErrorType.response]: Http status error [500]'),
      ],
    );

    // Add more test cases as needed for other scenarios.
  });
}