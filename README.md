# taskmanager
taskmanager is a Flutter application that provides a user-friendly interface for managing tasks, activities, comments, and user profiles. The application utilizes the APIs provided by the [taskmanager](https://github.com/kipsangmarion/taskmanager) Django project. It implements the Dio package for making API calls and follows the BLoC pattern for state management.

## Features

- User authentication and authorization using the Django project's APIs that utilizes token authentication.
- Task creation, retrieval, updating, and deletion.
- Activity logging for tasks.
- Commenting on tasks and activities.
- User profile management.
- Integration with the "taskmanager" Django project APIs.

## Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- TaskManager Django Project: [TaskManager Django Project Repository](https://github.com/kipsangmarion/taskmanager)

## Installation

1. Clone the repository:

   ```shell
   https://github.com/kipsangmarion/taskmanager-frontend
   cd taskmanager-frontend
   ```

2. Set up the taskmanager Django project API URL:

   In the `lib/network/api/endpoints.dart` file, update the `apiBaseUrl` variable with the URL of your deployed taskmanager Django project API.

3. Run the application:

   ```shell
   flutter run
   ```

4. Access the TaskManager application on your device/emulator.

## Dependencies

The TaskManager Flutter application relies on the following key dependencies:

- `dio`: A powerful HTTP client for making API calls.
- `flutter_bloc`: A state management library based on the BLoC pattern.
- `equatable`: A package to simplify equality comparisons between Dart objects.
- `flutter_modular`: A package for handling dependency injection and module management.
- `get_it`: A package for dependency injection and service locator.

## Project Structure

The project follows a modular structure known as feature-based clean architechture, separating different functionalities into separate modules. The key directories are as follows:

- `lib/network`: Contains the Url endpoints, Dio client and Dio Exceptions
- `lib/models`: Contains the different feature models such as users, tasks, activities, comments, and user profiles, login and pagenation model.
- `lib/di`: Contains the service locators.
- `lib/main.dart`: The entry point of the application and contains the dependency injection.
- `lib/auth`: Contains APIs, repository, blocs and views for handling authentication in the application.
- `lib/user_profile`: Contains APIs, repository, blocs and views for managing the user's profile.
- `lib/task`: Contains APIs, repository, blocs and views for managing tasks.
- `lib/activity`: Contains APIs, repository, blocs and views for managing activities.
- `lib/comment`: Contains APIs, repository, blocs and views for managing comments.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please create a new issue or submit a pull request.

