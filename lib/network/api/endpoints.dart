class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = 'https://ddf7-217-23-3-91.ngrok-free.app/';

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  static const String users = '/users';

  static const String register = 'taskmaster/register/';
  static const String login = 'taskmaster/login/';
  static const String changePassword = 'taskmaster/change_password/';
  static const String logout = 'taskmaster/logout/';
  static const String logoutAll = 'taskmaster/logout_all/';

  static const String userProfile = 'taskmaster/userprofile/';
  static const String task = 'taskmaster/task/';
  static const String activity = 'taskmaster/activity/';
  static const String comment = 'taskmaster/comment';
}