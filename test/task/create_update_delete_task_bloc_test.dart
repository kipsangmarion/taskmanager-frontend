import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:taskmanager_frontend/task/task_repository.dart';
import 'package:taskmanager_frontend/task/create_update_delete_bloc/create_update_delete_task_bloc.dart';
import 'package:taskmanager_frontend/models/task/task_model.dart';

// Mock the ActivityRepository
class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  group('CreateUpdateDeleteTaskBloc', () {
    // Initialize the mock repository
    final MockTaskRepository mockTaskRepository =
    MockTaskRepository();

    // Create a sample ActivityModel for testing
    const sampleTask = TaskModel(
        id: 1, title: 'Sample Title', desc: 'Sample Description');

    test(
        'emits [CreateUpdateDeleteTaskLoading, CreateUpdateDeleteTaskSuccess] '
            'when CreateTask event is added with successful task creation',
            () async {
          // Stub the createActivity method in the mock repository to return the sampleActivity
          when(mockTaskRepository.createTask(any))
              .thenAnswer((_) async => sampleTask);

          final bloc = CreateUpdateDeleteTaskBloc(
              taskRepository: mockTaskRepository);

          expectLater(
            bloc.stream,
            emitsInOrder([
              CreateUpdateDeleteTaskLoading(),
              const CreateUpdateDeleteTaskSuccess(sampleTask),
            ]),
          );

          bloc.add(const CreateTask(sampleTask));
        });

    test(
        'emits [CreateUpdateDeleteTaskLoading, CreateUpdateDeleteTaskSuccess] '
            'when UpdateTask event is added with successful task update',
            () async {
          // Stub the updateActivity method in the mock repository to return the sampleActivity
          when(mockTaskRepository.updateTask(any))
              .thenAnswer((_) async => sampleTask);

          final bloc = CreateUpdateDeleteTaskBloc(
              taskRepository: mockTaskRepository);

          expectLater(
            bloc.stream,
            emitsInOrder([
              CreateUpdateDeleteTaskLoading(),
              const CreateUpdateDeleteTaskSuccess(sampleTask),
            ]),
          );

          bloc.add(const UpdateTask(sampleTask));
        });

    test(
        'emits [CreateUpdateDeleteTaskLoading, CreateUpdateDeleteTaskSuccess] '
            'when DeleteTask event is added with successful task deletion',
            () async {
          // Stub the deleteActivity method in the mock repository to return the sampleActivity
          when(mockTaskRepository.deleteTask(any))
              .thenAnswer((_) async => sampleTask);

          final bloc = CreateUpdateDeleteTaskBloc(
              taskRepository: mockTaskRepository);

          expectLater(
            bloc.stream,
            emitsInOrder([
              CreateUpdateDeleteTaskLoading(),
              const CreateUpdateDeleteTaskSuccess(sampleTask),
            ]),
          );

          bloc.add(const DeleteTask(sampleTask));
        });

    test(
        'emits [CreateUpdateDeleteTaskLoading, CreateUpdateDeleteTaskSuccess] '
            'when RetrieveIndividualTask event is added with successful task retrieval',
            () async {
          // Stub the retrieveSpecificActivity method in the mock repository to return the sampleActivity
          when(mockTaskRepository.retrieveSpecificTask(any))
              .thenAnswer((_) async => sampleTask);

          final bloc = CreateUpdateDeleteTaskBloc(
              taskRepository: mockTaskRepository);

          expectLater(
            bloc.stream,
            emitsInOrder([
              CreateUpdateDeleteTaskLoading(),
              const CreateUpdateDeleteTaskSuccess(sampleTask),
            ]),
          );

          bloc.add(const RetrieveIndividualTask(1));
        });

    // Add more test cases as needed for other scenarios.

    // Close the bloc after testing
  });
}
